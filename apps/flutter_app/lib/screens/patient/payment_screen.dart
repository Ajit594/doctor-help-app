import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/constants.dart';
import '../../navigation/app_router.dart';
import '../../providers/providers.dart';
import '../../services/cashfree_checkout_helper.dart';
import '../../widgets/app_button.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String appointmentId;
  final double amount;
  final String doctorName;

  const PaymentScreen({
    super.key,
    required this.appointmentId,
    required this.amount,
    required this.doctorName,
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  bool _isPaying = false;

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _showSuccessDialog(String transactionId) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Booking confirmed successfully.'),
            const SizedBox(height: UIConstants.spacingSmall),
            Text('Txn ID: $transactionId'),
            Text('Amount: ₹${widget.amount.toStringAsFixed(0)}'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    context.go(AppRoutes.patientBookings);
  }

  /// Bounded poll for a webhook-confirmed final status after the SDK checkout
  /// completes — the SDK's own success callback isn't proof of a server-confirmed
  /// payment, only the backend (via webhook or this live check) is.
  Future<String> _pollForConfirmedStatus(String paymentId) async {
    final paymentService = ref.read(paymentServiceProvider);
    for (var attempt = 0; attempt < 5; attempt++) {
      final statusResponse = await paymentService.getPaymentStatus(paymentId, live: true);
      final status = statusResponse.data?['status']?.toString();
      if (status == 'success' || status == 'failed') {
        return status!;
      }
      await Future.delayed(const Duration(seconds: 2));
    }
    return 'pending';
  }

  Future<void> _handlePay() async {
    setState(() => _isPaying = true);

    final paymentService = ref.read(paymentServiceProvider);
    final response = await paymentService.initiatePayment(
      appointmentId: widget.appointmentId,
      amount: widget.amount,
    );

    if (!mounted) return;

    if (!response.success || response.data == null) {
      setState(() => _isPaying = false);
      _showError(response.error ?? 'Payment failed. Please try again.');
      return;
    }

    final data = response.data!;
    final status = data['status']?.toString();
    final mode = data['mode']?.toString();
    final paymentId = data['paymentId']?.toString();

    // Already paid (short-circuit) or an instant demo-mode success.
    if (status == 'success') {
      setState(() => _isPaying = false);
      final transactionId = data['transactionId']?.toString() ?? paymentId ?? 'TXN';
      await _showSuccessDialog(transactionId);
      return;
    }

    if (mode == 'cashfree') {
      final cashfree = data['cashfree'] as Map<String, dynamic>?;
      if (cashfree == null || paymentId == null) {
        setState(() => _isPaying = false);
        _showError('Payment could not be started. Please try again.');
        return;
      }

      final checkoutResult = await CashfreeCheckoutHelper().launchCheckout(
        orderId: cashfree['orderId'].toString(),
        paymentSessionId: cashfree['paymentSessionId'].toString(),
        environment: cashfree['environment'].toString(),
      );

      if (!mounted) return;

      if (!checkoutResult.success) {
        setState(() => _isPaying = false);
        _showError(checkoutResult.errorMessage ?? 'Payment was not completed.');
        return;
      }

      final finalStatus = await _pollForConfirmedStatus(paymentId);
      if (!mounted) return;
      setState(() => _isPaying = false);

      if (finalStatus == 'success') {
        await _showSuccessDialog(paymentId);
      } else if (finalStatus == 'failed') {
        _showError('Payment failed. Please try again.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Payment is still processing. We\'ll notify you once it\'s confirmed — check My Bookings shortly.',
            ),
            backgroundColor: Colors.orange,
          ),
        );
        context.go(AppRoutes.patientBookings);
      }
      return;
    }

    setState(() => _isPaying = false);
    _showError('Unexpected payment response. Please try again.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(UIConstants.spacingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(UIConstants.spacingLarge),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(UIConstants.radiusMedium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consultation Fee',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: UIConstants.spacingSmall),
                    Text(
                      '₹${widget.amount.toStringAsFixed(0)}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: UIConstants.spacingSmall),
                    Text('Doctor: ${widget.doctorName}'),
                  ],
                ),
              ),
              const SizedBox(height: UIConstants.spacing2XLarge),
              Text(
                'Tap Pay to open secure checkout and choose UPI, card, or net banking.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: UIConstants.spacingLarge),
              AppButton(
                label: 'Pay ₹${widget.amount.toStringAsFixed(0)}',
                isLoading: _isPaying,
                onPressed: _handlePay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
