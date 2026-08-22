import { Router } from 'express';
import { handleCashfreeWebhook } from './webhook';

const router = Router();

// No auth middleware — Cashfree calls this server-to-server. Authenticity comes from
// signature verification inside the handler, not a JWT.
router.post('/cashfree', handleCashfreeWebhook);

export { router as paymentsWebhookRouter };
