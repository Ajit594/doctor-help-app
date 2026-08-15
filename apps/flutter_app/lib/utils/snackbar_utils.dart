import 'package:flutter/material.dart';

/// Show a mapped Snackbar for OTP/network results.
void showOtpResultSnackBar(
  BuildContext context,
  String? error, {
  required VoidCallback? onRetry,
  bool success = false,
  String? successMessage,
}) {
  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(successMessage ?? 'OTP sent successfully'),
        backgroundColor: Colors.green,
      ),
    );
    return;
  }

  final msg = error ?? 'Failed to send OTP';
  final lower = msg.toLowerCase();

  // No internet
  if (lower.contains('no internet') ||
      lower.contains('network is unreachable')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No internet connection. Please check your network.'),
        backgroundColor: Colors.orange,
        action: null,
      ),
    );
    return;
  }

  // Cooldown / wait messages
  if (lower.contains('wait') ||
      lower.contains('too many requests') ||
      lower.contains('please try again later')) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  // Generic network error — allow retry
  if (lower.contains('network error') ||
      lower.contains('socketexception') ||
      lower.contains('request timeout')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Network error. Please try again.'),
        backgroundColor: Colors.red,
        action: null,
      ),
    );
    return;
  }

  // Default error
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    ),
  );
}
