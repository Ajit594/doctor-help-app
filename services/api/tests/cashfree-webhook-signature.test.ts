import { afterEach, beforeEach, describe, expect, it } from 'vitest';
import crypto from 'crypto';
import { verifyCashfreeWebhookSignature } from '../src/modules/payments/cashfree';

const SECRET = 'test-secret-key';

function sign(timestamp: string, body: string): string {
    return crypto.createHmac('sha256', SECRET).update(timestamp + body).digest('base64');
}

describe('verifyCashfreeWebhookSignature', () => {
    const originalSecret = process.env.CASHFREE_CLIENT_SECRET;

    beforeEach(() => {
        process.env.CASHFREE_CLIENT_SECRET = SECRET;
    });

    afterEach(() => {
        process.env.CASHFREE_CLIENT_SECRET = originalSecret;
    });

    it('accepts a correctly signed payload', () => {
        const timestamp = '1700000000';
        const body = JSON.stringify({ type: 'PAYMENT_SUCCESS_WEBHOOK' });
        const signature = sign(timestamp, body);

        expect(verifyCashfreeWebhookSignature(Buffer.from(body), timestamp, signature)).toBe(true);
    });

    it('rejects a tampered body', () => {
        const timestamp = '1700000000';
        const body = JSON.stringify({ type: 'PAYMENT_SUCCESS_WEBHOOK' });
        const signature = sign(timestamp, body);
        const tamperedBody = JSON.stringify({ type: 'PAYMENT_FAILED_WEBHOOK' });

        expect(verifyCashfreeWebhookSignature(Buffer.from(tamperedBody), timestamp, signature)).toBe(false);
    });

    it('rejects a tampered timestamp', () => {
        const timestamp = '1700000000';
        const body = JSON.stringify({ type: 'PAYMENT_SUCCESS_WEBHOOK' });
        const signature = sign(timestamp, body);

        expect(verifyCashfreeWebhookSignature(Buffer.from(body), '1700000001', signature)).toBe(false);
    });

    it('rejects when the client secret is not configured', () => {
        delete process.env.CASHFREE_CLIENT_SECRET;
        const timestamp = '1700000000';
        const body = JSON.stringify({ type: 'PAYMENT_SUCCESS_WEBHOOK' });
        const signature = sign(timestamp, body);

        expect(verifyCashfreeWebhookSignature(Buffer.from(body), timestamp, signature)).toBe(false);
    });
});
