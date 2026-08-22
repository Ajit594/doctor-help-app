import { Request, Response } from 'express';
import { randomUUID } from 'crypto';
import { Appointment, Doctor, Payment, IPayment } from '../../models';
import { AuthenticatedRequest } from '../../middleware/auth';
import { logger } from '../../utils/logger';
import { createCashfreeOrder, getCashfreeOrder, CASHFREE_ENV } from './cashfree';
import {
    notifyAppointmentStatusChanged,
    notifyPaymentStatus,
} from '../notifications';

const PAYMENT_MODE = (process.env.PAYMENT_MODE || 'demo').toLowerCase();

// TODO(payment-hardening-followups): not built in this pass — see plan doc.
// - Reconciliation cron sweep for stale created/pending rows (no cron infra in this repo yet).
// - Alerting on repeated webhook verification failures (only logged for now).
// - Duplicate-order dedupe for the lab-order path (no natural dedupe key today).

/**
 * Transition a payment to 'success' and, if it's linked to an appointment, confirm that
 * appointment (payment + notification side-effects). Single source of truth for "payment
 * succeeded" — called from the demo path, the Cashfree webhook, and the live-status fallback.
 * Idempotent: no-ops if the payment is already marked success.
 */
export async function markPaymentSuccessAndConfirm(payment: IPayment, providerTxnId?: string) {
    if (payment.status === 'success') return;

    payment.status = 'success';
    if (providerTxnId) payment.providerTxnId = providerTxnId;
    await payment.save();

    await notifyPaymentStatus({
        userId: payment.userId,
        paymentId: payment.paymentId,
        status: 'success',
    });

    if (payment.appointmentId) {
        const appointment = await Appointment.findById(payment.appointmentId);
        if (appointment && appointment.paymentStatus !== 'paid') {
            appointment.paymentStatus = 'paid';
            appointment.status = 'confirmed';
            await appointment.save();

            const doctor = await Doctor.findById(appointment.doctorId).lean();
            await notifyAppointmentStatusChanged({
                patientUserId: appointment.patientId.toString(),
                doctorUserId: doctor?.userId?.toString(),
                appointmentId: appointment._id.toString(),
                status: 'confirmed',
            });
        }
    }
}

/**
 * Transition a payment to 'failed'. Single source of truth for "payment failed" — called
 * from the Cashfree webhook and the live-status fallback. Idempotent: no-ops if the payment
 * already reached a terminal state (success or failed).
 */
export async function markPaymentFailed(payment: IPayment, reason?: string) {
    if (payment.status === 'success' || payment.status === 'failed') return;

    payment.status = 'failed';
    if (reason) {
        payment.meta = { ...(payment.meta || {}), failureReason: reason };
    }
    await payment.save();

    await notifyPaymentStatus({
        userId: payment.userId,
        paymentId: payment.paymentId,
        status: 'failed',
    });
}

type InitiateParams = {
    userId: string;
    appointment: any;
    appointmentId?: string;
    amount: number;
    currency: string;
    purpose: string;
};

/** Demo mode: instant simulated success, no external gateway call. Used for local dev and the admin PaymentDemo page. */
async function initiateDemoPayment(res: Response, params: InitiateParams) {
    const { userId, appointmentId, amount, currency, purpose } = params;

    const paymentId = `PAY-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
    const providerTxnId = `DEMO-${randomUUID()}`;

    const payment = await Payment.create({
        paymentId,
        userId,
        appointmentId,
        provider: 'demo',
        amount,
        currency,
        purpose,
        status: 'created',
        meta: { mode: 'demo', simulated: true },
    });

    await markPaymentSuccessAndConfirm(payment, providerTxnId);

    return res.status(201).json({
        success: true,
        message: 'Demo payment successful',
        data: {
            paymentId: payment.paymentId,
            status: payment.status,
            transactionId: payment.providerTxnId,
            mode: 'demo',
            appointmentId: appointmentId || null,
        },
    });
}

/** Cashfree mode: create a real order and hand the client a payment_session_id for checkout. */
async function initiateCashfreePayment(req: AuthenticatedRequest, res: Response, params: InitiateParams) {
    const { userId, appointmentId, amount, currency, purpose } = params;

    // Dedupe: reuse a recent, still-open order for this appointment instead of creating a
    // duplicate Cashfree order on a retried initiate call (double-tap, network retry, etc).
    if (appointmentId) {
        const existing = await Payment.findOne({
            appointmentId,
            provider: 'cashfree',
            status: { $in: ['created', 'pending'] },
        }).sort({ createdAt: -1 });

        const isRecent = !!existing && Date.now() - existing.createdAt.getTime() < 15 * 60 * 1000;
        if (existing && isRecent && existing.paymentSessionId) {
            return res.status(200).json({
                success: true,
                message: 'Payment already initiated. Continue checkout.',
                data: {
                    paymentId: existing.paymentId,
                    status: existing.status,
                    mode: 'cashfree',
                    appointmentId: appointmentId || null,
                    cashfree: {
                        orderId: existing.paymentId,
                        paymentSessionId: existing.paymentSessionId,
                        environment: CASHFREE_ENV,
                    },
                },
            });
        }
    }

    const paymentId = `PAY-${Date.now()}-${Math.floor(Math.random() * 1000)}`;

    const payment = await Payment.create({
        paymentId,
        userId,
        appointmentId,
        provider: 'cashfree',
        amount,
        currency,
        purpose,
        status: 'created',
        meta: { mode: 'cashfree' },
    });

    try {
        const webhookUrl = process.env.CASHFREE_WEBHOOK_URL || '';
        const order = await createCashfreeOrder({
            orderId: paymentId,
            amount,
            currency,
            customerId: userId,
            customerPhone: req.user?.phone || '',
            notifyUrl: webhookUrl,
        });

        payment.status = 'pending';
        payment.cfOrderId = order.cfOrderId;
        payment.paymentSessionId = order.paymentSessionId;
        await payment.save();

        return res.status(201).json({
            success: true,
            message: 'Payment initiated. Complete checkout to confirm.',
            data: {
                paymentId: payment.paymentId,
                status: payment.status,
                mode: 'cashfree',
                appointmentId: appointmentId || null,
                cashfree: {
                    orderId: payment.paymentId,
                    paymentSessionId: order.paymentSessionId,
                    environment: CASHFREE_ENV,
                },
            },
        });
    } catch (error) {
        await markPaymentFailed(payment, 'Failed to create Cashfree order');
        logger.error('createCashfreeOrder error:', error);
        return res.status(502).json({ success: false, error: 'Failed to initiate payment with gateway' });
    }
}

/** POST /api/payments/initiate — Initiate payment. Demo mode simulates success; Cashfree mode opens a real order. */
export const initiatePayment = async (req: Request, res: Response) => {
    try {
        const authReq = req as AuthenticatedRequest;
        const userId = authReq.user?.userId;
        if (!userId) {
            return res.status(401).json({ success: false, error: 'Unauthorized' });
        }

        const { appointmentId, amount, currency = 'INR', purpose = 'doctor_consultation' } = req.body as {
            appointmentId?: string;
            amount: number;
            currency?: string;
            purpose?: string;
        };

        if (!Number.isFinite(amount) || amount <= 0) {
            return res.status(400).json({ success: false, error: 'Amount must be greater than 0' });
        }

        let appointment = null as any;
        if (appointmentId) {
            appointment = await Appointment.findById(appointmentId);
            if (!appointment) {
                return res.status(404).json({ success: false, error: 'Appointment not found' });
            }

            const isAdmin = authReq.user?.role === 'admin';
            if (!isAdmin && appointment.patientId.toString() !== userId) {
                return res.status(403).json({ success: false, error: 'Not authorized for this appointment' });
            }

            if (appointment.paymentStatus === 'paid') {
                return res.json({
                    success: true,
                    message: 'Appointment already paid',
                    data: {
                        status: 'success',
                        transactionId: `PAID-${appointment._id}`,
                        mode: PAYMENT_MODE,
                        appointmentId: String(appointment._id),
                    },
                });
            }
        }

        const params: InitiateParams = { userId, appointment, appointmentId, amount, currency, purpose };

        if (PAYMENT_MODE === 'cashfree') {
            return await initiateCashfreePayment(authReq, res, params);
        }

        return await initiateDemoPayment(res, params);
    } catch (error) {
        logger.error('initiatePayment error:', error);
        return res.status(500).json({ success: false, error: 'Failed to initiate payment' });
    }
};

/** GET /api/payments/:paymentId — Fetch payment status. Pass ?live=true to force a live Cashfree order check. */
export const getPaymentStatus = async (req: Request, res: Response) => {
    try {
        const authReq = req as AuthenticatedRequest;
        const userId = authReq.user?.userId;
        if (!userId) {
            return res.status(401).json({ success: false, error: 'Unauthorized' });
        }

        const { paymentId } = req.params;
        const live = req.query.live === 'true';

        const payment = await Payment.findOne({ paymentId });
        if (!payment) {
            return res.status(404).json({ success: false, error: 'Payment not found' });
        }

        const isAdmin = authReq.user?.role === 'admin';
        if (!isAdmin && payment.userId !== userId) {
            return res.status(403).json({ success: false, error: 'Not authorized to view this payment' });
        }

        if (live && payment.provider === 'cashfree' && (payment.status === 'created' || payment.status === 'pending')) {
            try {
                const cfOrder = await getCashfreeOrder(payment.paymentId);
                if (cfOrder.orderStatus === 'PAID') {
                    await markPaymentSuccessAndConfirm(payment);
                } else if (cfOrder.orderStatus === 'EXPIRED' || cfOrder.orderStatus === 'TERMINATED') {
                    await markPaymentFailed(payment, `Cashfree order status: ${cfOrder.orderStatus}`);
                }
            } catch (liveCheckError) {
                // Fall through and return the last-known local status rather than failing the request.
                logger.error('getPaymentStatus live check failed:', liveCheckError);
            }
        }

        return res.json({
            success: true,
            data: {
                paymentId: payment.paymentId,
                appointmentId: payment.appointmentId,
                amount: payment.amount,
                currency: payment.currency,
                status: payment.status,
                provider: payment.provider,
                transactionId: payment.providerTxnId,
                createdAt: payment.createdAt,
            },
        });
    } catch (error) {
        logger.error('getPaymentStatus error:', error);
        return res.status(500).json({ success: false, error: 'Failed to fetch payment status' });
    }
};
