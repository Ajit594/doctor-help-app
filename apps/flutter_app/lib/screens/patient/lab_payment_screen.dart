import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/constants.dart';
import '../../navigation/app_router.dart';
import '../../providers/providers.dart';
import '../../services/cashfree_checkout_helper.dart';
import '../../widgets/app_button.dart';

class LabPaymentScreen extends ConsumerStatefulWidget {
  final String labId;
  final String labName;
  final double amount;
  final List<String> selectedTestIds;
  final List<String> selectedPackageIds;
  final String patientName;
  final int patientAge;
  final String patientGender;
  final String? relationship;
  final String? prescriptionUrl;
  final DateTime slotDate;
  final String slotTime;
  final bool homeCollection;
  final String address;
  final List<String> testNames;
  final List<String> packageNames;

  const LabPaymentScreen({
    super.key,
    required this.labId,
    required this.labName,
    required this.amount,
    required this.selectedTestIds,
    required this.selectedPackageIds,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    this.relationship,
    this.prescriptionUrl,
    required this.slotDate,
    required this.slotTime,
    required this.homeCollection,
    required this.address,
    required this.testNames,
    required this.packageNames,
  });

  @override
  ConsumerState<LabPaymentScreen> createState() => _LabPaymentScreenState();
}

class _LabPaymentScreenState extends ConsumerState<LabPaymentScreen> {
  bool _isPaying = false;

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  /// Bounded poll for a webhook-confirmed final status after the SDK checkout
  /// completes — the SDK's own success callback isn't proof of a server-confirmed
  /// payment, only the backend (via webhook or this live check) is. The lab order
  /// itself can only be created once this reaches 'success' (backend enforces it too).
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

  Future<void> _createOrderAndShowSuccess(String paymentId, String transactionId) async {
    final labService = ref.read(labServiceProvider);
    final order = await labService.createLabOrder(
      paymentId: paymentId,
      labId: widget.labId,
      testIds: widget.selectedTestIds,
      packageIds: widget.selectedPackageIds,
      patientName: widget.patientName,
      patientAge: widget.patientAge,
      patientGender: widget.patientGender,
      relationship: widget.relationship,
      prescriptionUrl: widget.prescriptionUrl,
      slotDate: widget.slotDate,
      slotTime: widget.slotTime,
      homeCollection: widget.homeCollection,
      address: widget.address,
    );

    if (!mounted) return;

    if (order == null) {
      _showError('Payment succeeded but booking creation failed. Contact support with your transaction ID.');
      return;
    }

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lab booking confirmed successfully.'),
            const SizedBox(height: UIConstants.spacingSmall),
            Text('Txn ID: $transactionId'),
            Text('Amount: ₹${widget.amount.toStringAsFixed(0)}'),
            const SizedBox(height: UIConstants.spacingSmall),
            Text('Lab: ${widget.labName}'),
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

  Future<void> _handlePay() async {
    setState(() => _isPaying = true);

    try {
      final paymentService = ref.read(paymentServiceProvider);
      final paymentResponse = await paymentService.initiatePayment(
        amount: widget.amount,
        purpose: 'lab_booking',
      );

      if (!mounted) return;

      if (!paymentResponse.success || paymentResponse.data == null) {
        setState(() => _isPaying = false);
        _showError(paymentResponse.error ?? 'Payment failed. Please try again.');
        return;
      }

      final data = paymentResponse.data!;
      final status = data['status']?.toString();
      final mode = data['mode']?.toString();
      final paymentId = data['paymentId']?.toString();

      // Instant demo-mode success.
      if (status == 'success' && paymentId != null) {
        final transactionId = data['transactionId']?.toString() ?? paymentId;
        await _createOrderAndShowSuccess(paymentId, transactionId);
        if (mounted) setState(() => _isPaying = false);
        return;
      }

      if (mode == 'cashfree' && paymentId != null) {
        final cashfree = data['cashfree'] as Map<String, dynamic>?;
        if (cashfree == null) {
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

        if (finalStatus == 'success') {
          await _createOrderAndShowSuccess(paymentId, paymentId);
          if (mounted) setState(() => _isPaying = false);
        } else if (finalStatus == 'failed') {
          setState(() => _isPaying = false);
          _showError('Payment failed. Please try again.');
        } else {
          setState(() => _isPaying = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Payment is still processing. Please check back in a few minutes and retry booking if it doesn\'t confirm.',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      setState(() => _isPaying = false);
      _showError('Unexpected payment response. Please try again.');
    } catch (e) {
      if (!mounted) return;
      setState(() => _isPaying = false);
      _showError('Error: ${e.toString().replaceFirst('Exception: ', '')}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Payment'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(UIConstants.spacingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary Section
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
                      'Lab Booking Summary',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: UIConstants.spacingMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lab',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Expanded(
                          child: Text(
                            widget.labName,
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: UIConstants.spacingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Patient',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          widget.patientName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: UIConstants.spacingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Collection Date',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          '${widget.slotDate.year}-${widget.slotDate.month.toString().padLeft(2, '0')}-${widget.slotDate.day.toString().padLeft(2, '0')}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: UIConstants.spacingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time Slot',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          widget.slotTime,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (widget.testNames.isNotEmpty) ...[
                      const SizedBox(height: UIConstants.spacingSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tests',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Expanded(
                            child: Text(
                              widget.testNames.join(', '),
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (widget.packageNames.isNotEmpty) ...[
                      const SizedBox(height: UIConstants.spacingSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Packages',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Expanded(
                            child: Text(
                              widget.packageNames.join(', '),
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${widget.amount.toStringAsFixed(0)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
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

              // Pay Button
              AppButton(
                label: 'Pay ₹${widget.amount.toStringAsFixed(0)}',
                isLoading: _isPaying,
                onPressed: _isPaying ? null : _handlePay,
              ),
              const SizedBox(height: UIConstants.spacingMedium),

              // Cancel Button
              OutlinedButton(
                onPressed: _isPaying ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
