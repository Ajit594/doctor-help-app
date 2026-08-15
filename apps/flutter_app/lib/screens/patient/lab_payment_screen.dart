import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/constants.dart';
import '../../navigation/app_router.dart';
import '../../providers/providers.dart';
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
  String _selectedMethod = 'upi';

  Future<void> _handlePay() async {
    setState(() => _isPaying = true);

    try {
      final paymentService = ref.read(paymentServiceProvider);
      final paymentResponse = await paymentService.initiateDemoPayment(
        amount: widget.amount,
        purpose: 'lab_booking',
      );

      if (!mounted) return;
      setState(() => _isPaying = false);

      if (!paymentResponse.success || paymentResponse.data == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              paymentResponse.error ?? 'Payment failed. Please try again.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final paymentData = paymentResponse.data!;
      final paymentStatus = (paymentData['status'] ?? '').toString();
      final paymentId = (paymentData['paymentId'] ?? '').toString();

      if (paymentStatus != 'success' || paymentId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment not completed. Please try again.'),
          ),
        );
        return;
      }

      // Create lab order after successful payment
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create booking')),
        );
        return;
      }

      final transactionId =
          (paymentData['transactionId'] ?? paymentData['paymentId'] ?? '')
              .toString();

      // Show success dialog
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
              const Text('Lab booking confirmed successfully.'),
              const SizedBox(height: UIConstants.spacingSmall),
              if (transactionId.isNotEmpty)
                Text('Txn ID: $transactionId')
              else
                const Text('Txn ID: DEMO-TXN'),
              Text('Amount: ₹${widget.amount.toStringAsFixed(0)}'),
              const SizedBox(height: UIConstants.spacingSmall),
              Text('Lab: ${widget.labName}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      context.go(AppRoutes.patientBookings);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isPaying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString().replaceFirst('Exception: ', '')}'),
          backgroundColor: Colors.red,
        ),
      );
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

              // Payment Method Selection
              Text(
                'Select Payment Method',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: UIConstants.spacingMedium),
              RadioGroup<String>(
                groupValue: _selectedMethod,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedMethod = value);
                  }
                },
                child: const Column(
                  children: [
                    Card(
                      child: RadioListTile<String>(
                        value: 'upi',
                        title: Text('UPI'),
                        subtitle: Text('Pay using any UPI app (Google Pay, PhonePe, etc.)'),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: UIConstants.spacingMedium,
                          vertical: UIConstants.spacingSmall,
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.spacingSmall),
                    Card(
                      child: RadioListTile<String>(
                        value: 'card',
                        title: Text('Credit / Debit Card'),
                        subtitle: Text('Visa, Mastercard, or other supported cards'),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: UIConstants.spacingMedium,
                          vertical: UIConstants.spacingSmall,
                        ),
                      ),
                    ),
                    SizedBox(height: UIConstants.spacingSmall),
                    Card(
                      child: RadioListTile<String>(
                        value: 'netbanking',
                        title: Text('Net Banking'),
                        subtitle: Text('All major banks supported'),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: UIConstants.spacingMedium,
                          vertical: UIConstants.spacingSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: UIConstants.spacing2XLarge),

              // Info message
              Container(
                padding: const EdgeInsets.all(UIConstants.spacingMedium),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(UIConstants.radiusSmall),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Text(
                  'Demo Mode: This flow simulates successful payment for testing and approval purposes.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.blue[900],
                  ),
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
