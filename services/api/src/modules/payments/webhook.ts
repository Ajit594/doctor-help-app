import { Request, Response } from 'express';
import { Payment, PaymentWebhookEvent } from '../../models';
import { verifyCashfreeWebhookSignature } from './cashfree';
import { markPaymentFailed, markPaymentSuccessAndConfirm } from './controller';
import { logger } from '../../utils/logger';

const SUCCESS_EVENT = 'PAYMENT_SUCCESS_WEBHOOK';
const FAILED_EVENTS = new Set(['PAYMENT_FAILED_WEBHOOK', 'PAYMENT_USER_DROPPED_WEBHOOK']);

/** POST /api/payments/webhook/cashfree — server-to-server callback, no auth. Signature-verified, idempotent. */
export const handleCashfreeWebhook = async (req: Request, res: Response) => {
    try {
        const rawBody = req.rawBody;
        const signature = req.header('x-webhook-signature');
        const timestamp = req.header('x-webhook-timestamp');

        if (!rawBody || !signature || !timestamp || !verifyCashfreeWebhookSignature(rawBody, timestamp, signature)) {
            logger.error('Cashfree webhook signature verification failed');
            return res.status(400).json({ success: false, error: 'Invalid webhook signature' });
        }

        const payload = req.body as {
            type: string;
            data?: {
                order?: { order_id?: string };
                payment?: { cf_payment_id?: string; payment_status?: string };
            };
        };

        const orderId = payload.data?.order?.order_id;
        const cfPaymentId = payload.data?.payment?.cf_payment_id;

        if (!orderId) {
            logger.error('Cashfree webhook missing order_id', payload);
            return res.status(200).json({ success: true }); // Nothing actionable; ack to stop retries.
        }

        // Idempotency: first insert wins. A duplicate delivery hits the unique index and
        // short-circuits here without reprocessing the status transition.
        try {
            await PaymentWebhookEvent.create({
                orderId,
                eventType: payload.type,
                cfPaymentId,
                rawPayload: payload,
            });
        } catch (dupError: any) {
            if (dupError?.code === 11000) {
                return res.status(200).json({ success: true, message: 'Already processed' });
            }
            throw dupError;
        }

        const payment = await Payment.findOne({ paymentId: orderId });
        if (!payment) {
            logger.error(`Cashfree webhook for unknown paymentId: ${orderId}`);
            return res.status(200).json({ success: true }); // Ack — retrying won't help if the order doesn't exist locally.
        }

        if (payload.type === SUCCESS_EVENT) {
            await markPaymentSuccessAndConfirm(payment, cfPaymentId);
        } else if (FAILED_EVENTS.has(payload.type)) {
            await markPaymentFailed(payment, payload.type);
        }

        return res.status(200).json({ success: true });
    } catch (error) {
        logger.error('handleCashfreeWebhook error:', error);
        return res.status(500).json({ success: false, error: 'Webhook processing failed' });
    }
};
