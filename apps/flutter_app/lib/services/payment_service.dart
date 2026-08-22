import '../config/api_config.dart';
import '../models/api_response.dart';
import 'api_service.dart';

class PaymentService {
  final ApiService _apiService;

  PaymentService(this._apiService);

  /// Initiate a payment. The backend decides whether this is a simulated demo
  /// payment or a real Cashfree order based on server-side PAYMENT_MODE — the
  /// response's `data['mode']` tells the caller which one it got, and for
  /// `'cashfree'`, `data['cashfree']` carries `{ orderId, paymentSessionId, environment }`
  /// for launching the native checkout.
  Future<ApiResponse<Map<String, dynamic>>> initiatePayment({
    String? appointmentId,
    required double amount,
    String purpose = 'doctor_consultation',
  }) {
    final body = <String, dynamic>{
      'amount': amount,
      'currency': 'INR',
      'purpose': purpose,
    };

    if (appointmentId != null && appointmentId.trim().isNotEmpty) {
      body['appointmentId'] = appointmentId.trim();
    }

    return _apiService.post(
      ApiEndpoints.initiatePayment,
      body: body,
      fromJson: (json) => json,
    );
  }

  /// Fetch payment status. Pass [live] = true to force the backend to check the
  /// live Cashfree order status instead of just returning the last-known local
  /// status — used right after a checkout attempt completes, since the SDK's own
  /// success callback isn't proof of a server-confirmed payment.
  Future<ApiResponse<Map<String, dynamic>>> getPaymentStatus(
    String paymentId, {
    bool live = false,
  }) {
    final endpoint = ApiEndpoints.getPaymentStatus.replaceFirst(':paymentId', paymentId);
    return _apiService.get(
      live ? '$endpoint?live=true' : endpoint,
      fromJson: (json) => json,
    );
  }
}
