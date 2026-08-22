import mongoose, { Document, Schema } from 'mongoose';

export interface IPaymentWebhookEvent extends Document {
    orderId: string;
    eventType: string;
    cfPaymentId?: string;
    rawPayload: Record<string, unknown>;
    receivedAt: Date;
}

const PaymentWebhookEventSchema = new Schema<IPaymentWebhookEvent>({
    orderId: { type: String, required: true, index: true },
    eventType: { type: String, required: true },
    cfPaymentId: { type: String },
    rawPayload: { type: Schema.Types.Mixed, required: true },
    receivedAt: { type: Date, default: Date.now },
});

// Idempotency guard: a duplicate webhook delivery for the same order/event/payment
// hits this unique index and the handler treats the resulting E11000 as "already processed".
PaymentWebhookEventSchema.index(
    { orderId: 1, eventType: 1, cfPaymentId: 1 },
    { unique: true }
);

export const PaymentWebhookEvent = mongoose.model<IPaymentWebhookEvent>(
    'PaymentWebhookEvent',
    PaymentWebhookEventSchema
);
