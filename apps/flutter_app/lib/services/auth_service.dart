import 'dart:async';

import '../models/user.dart';
import '../models/api_response.dart';
import '../config/api_config.dart';
import 'api_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Auth API Service
class AuthService {
  final ApiService _apiService;

  const AuthService(this._apiService);

  /// Send OTP to phone number
  Future<ApiResponse<Map<String, dynamic>>> sendOtp(String phone) async {
    // Quick connectivity guard to fail fast on offline devices
    final hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      return const ApiResponse<Map<String, dynamic>>(
        success: false,
        error:
            'No internet connection. Please check your network and try again.',
      );
    }

    // Retry with exponential backoff for transient socket errors
    const int maxAttempts = 3;
    int attempt = 0;
    int delayMs = 500;

    while (true) {
      attempt++;
      try {
        final resp = await _apiService.post<Map<String, dynamic>>(
          ApiEndpoints.sendOtp,
          body: {'mobile': phone},
          fromJson: (m) => m,
        );

        // If the call succeeded or returned a non-network error, return it directly
        if (resp.success || attempt >= maxAttempts) return resp;

        // Otherwise, wait and retry
        await Future.delayed(Duration(milliseconds: delayMs));
        delayMs *= 2;
      } catch (e) {
        // If this was the last attempt, return structured error
        if (attempt >= maxAttempts) {
          return ApiResponse<Map<String, dynamic>>(
            success: false,
            error:
                'Network error while sending OTP. Please try again shortly. (${e.toString()})',
          );
        }

        await Future.delayed(Duration(milliseconds: delayMs));
        delayMs *= 2;
      }
    }
  }

  /// Verify OTP and get token
  Future<ApiResponse<VerifyOtpResponse>> verifyOtp(String phone, String otp) {
    return _apiService.post(
      ApiEndpoints.verifyOtp,
      body: {'mobile': phone, 'otp': otp},
      fromJson: (json) => VerifyOtpResponse.fromJson(json),
    );
  }

  /// Refresh token
  Future<ApiResponse<RefreshTokenResponse>> refreshToken() {
    return _apiService.post(
      ApiEndpoints.refreshToken,
      fromJson: (json) => RefreshTokenResponse.fromJson(json),
    );
  }

  /// Get current user
  Future<ApiResponse<User>> getMe() {
    return _apiService.get(
      ApiEndpoints.getMe,
      fromJson: (json) => User.fromJson(json),
    );
  }
}

/// Response models
class VerifyOtpResponse {
  final String token;
  final User user;

  VerifyOtpResponse({
    required this.token,
    required this.user,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class RefreshTokenResponse {
  final String token;

  RefreshTokenResponse({required this.token});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      token: json['token'] as String,
    );
  }
}
