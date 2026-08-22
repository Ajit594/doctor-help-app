import axios from 'axios';
import crypto from 'crypto';

const CASHFREE_ENV = (process.env.CASHFREE_ENV || 'sandbox').toLowerCase();
const CASHFREE_BASE_URL =
    CASHFREE_ENV === 'production'
        ? 'https://api.cashfree.com/pg'
        : 'https://sandbox.cashfree.com/pg';

function getHeaders() {
    const clientId = process.env.CASHFREE_CLIENT_ID;
    const clientSecret = process.env.CASHFREE_CLIENT_SECRET;
    const apiVersion = process.env.CASHFREE_API_VERSION;

    if (!clientId || !clientSecret || !apiVersion) {
        throw new Error('Cashfree credentials are not configured (CASHFREE_CLIENT_ID / CASHFREE_CLIENT_SECRET / CASHFREE_API_VERSION)');
    }

    return {
        'x-client-id': clientId,
        'x-client-secret': clientSecret,
        'x-api-version': apiVersion,
        'Content-Type': 'application/json',
    };
}

export interface CreateCashfreeOrderParams {
    orderId: string;
    amount: number;
    currency: string;
    customerId: string;
    customerPhone: string;
    customerEmail?: string;
    notifyUrl: string;
}

export interface CashfreeOrderResult {
    paymentSessionId: string;
    cfOrderId: string;
    orderStatus: string;
}

/** POST /orders — create a Cashfree order and get back a payment_session_id for checkout. */
export async function createCashfreeOrder(params: CreateCashfreeOrderParams): Promise<CashfreeOrderResult> {
    const response = await axios.post(
        `${CASHFREE_BASE_URL}/orders`,
        {
            order_id: params.orderId,
            order_amount: params.amount,
            order_currency: params.currency,
            customer_details: {
                customer_id: params.customerId,
                customer_phone: params.customerPhone,
                ...(params.customerEmail ? { customer_email: params.customerEmail } : {}),
            },
            order_meta: {
                notify_url: params.notifyUrl,
            },
        },
        { headers: getHeaders(), timeout: 15000 }
    );

    return {
        paymentSessionId: response.data.payment_session_id,
        cfOrderId: response.data.cf_order_id?.toString() ?? response.data.order_id,
        orderStatus: response.data.order_status,
    };
}

/** GET /orders/:orderId — fetch current order status directly from Cashfree (webhook fallback). */
export async function getCashfreeOrder(orderId: string): Promise<CashfreeOrderResult> {
    const response = await axios.get(`${CASHFREE_BASE_URL}/orders/${encodeURIComponent(orderId)}`, {
        headers: getHeaders(),
        timeout: 15000,
    });

    return {
        paymentSessionId: response.data.payment_session_id,
        cfOrderId: response.data.cf_order_id?.toString() ?? response.data.order_id,
        orderStatus: response.data.order_status,
    };
}

/**
 * Verify a Cashfree webhook signature.
 * Cashfree signs `timestamp + rawBody` with HMAC-SHA256 using the client secret, base64-encoded.
 */
export function verifyCashfreeWebhookSignature(rawBody: Buffer, timestamp: string, signature: string): boolean {
    const clientSecret = process.env.CASHFREE_CLIENT_SECRET;
    if (!clientSecret || !timestamp || !signature) return false;

    const expected = crypto
        .createHmac('sha256', clientSecret)
        .update(timestamp + rawBody.toString())
        .digest('base64');

    const expectedBuffer = Buffer.from(expected);
    const signatureBuffer = Buffer.from(signature);

    if (expectedBuffer.length !== signatureBuffer.length) return false;
    return crypto.timingSafeEqual(expectedBuffer, signatureBuffer);
}

export { CASHFREE_ENV, CASHFREE_BASE_URL };
