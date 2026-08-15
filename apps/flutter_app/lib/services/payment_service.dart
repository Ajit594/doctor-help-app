import '../config/api_config.dart';
import '../models/api_response.dart';
import 'api_service.dart';

class PaymentService {
  final ApiService _apiService;

  PaymentService(this._apiService);

  Future<ApiResponse<Map<String, dynamic>>> initiateDemoPayment({
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

  Future<ApiResponse<Map<String, dynamic>>> getPaymentStatus(String paymentId) {
    return _apiService.get(
      ApiEndpoints.getPaymentStatus.replaceFirst(':paymentId', paymentId),
      fromJson: (json) => json,
    );
  }
}
