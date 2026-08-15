import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/constants.dart';
import '../../models/lab.dart';
import '../../providers/providers.dart';
import 'lab_payment_screen.dart';

class LabBookingScreen extends ConsumerStatefulWidget {
  final String labId;
  final String? preselectedTestId;

  const LabBookingScreen({
    super.key,
    required this.labId,
    this.preselectedTestId,
  });

  @override
  ConsumerState<LabBookingScreen> createState() => _LabBookingScreenState();
}

class _LabBookingScreenState extends ConsumerState<LabBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _slotTimeController = TextEditingController(text: '09:00 AM');
  final _addressController = TextEditingController();

  bool _loading = true;
  bool _uploadingPrescription = false;
  bool _homeCollection = true;
  String _gender = 'male';
  DateTime _slotDate = DateTime.now().add(const Duration(days: 1));
  String? _prescriptionUrl;

  LabCatalog? _catalog;
  final Set<String> _selectedTestIds = <String>{};
  final Set<String> _selectedPackageIds = <String>{};

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _relationshipController.dispose();
    _slotTimeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadCatalog() async {
    setState(() {
      _loading = true;
    });

    final catalog =
        await ref.read(labServiceProvider).getLabCatalog(widget.labId);
    if (!mounted) return;

    setState(() {
      _catalog = catalog;
      _loading = false;
      if (widget.preselectedTestId != null &&
          widget.preselectedTestId!.isNotEmpty) {
        _selectedTestIds.add(widget.preselectedTestId!);
      }
    });
  }

  double get _totalAmount {
    if (_catalog == null) return 0;

    final testTotal = _catalog!.tests
        .where((t) => _selectedTestIds.contains(t.id))
        .fold<double>(0, (sum, test) => sum + test.effectivePrice);

    final packageTotal = _catalog!.packages
        .where((p) => _selectedPackageIds.contains(p.id))
        .fold<double>(0, (sum, pkg) => sum + pkg.effectivePrice);

    return testTotal + packageTotal;
  }

  List<String> get _preparationInstructions {
    if (_catalog == null) return <String>[];

    final testInstructions = _catalog!.tests
        .where((t) => _selectedTestIds.contains(t.id))
        .expand((t) {
      final lines = <String>[...t.preparationInstructions];
      if ((t.fastingHours ?? 0) > 0) {
        lines.add('Fasting required: ${t.fastingHours} hours for ${t.name}');
      }
      return lines;
    }).toList();

    final packageInstructions = _catalog!.packages
        .where((p) => _selectedPackageIds.contains(p.id))
        .expand((p) => p.preparationInstructions)
        .toList();

    return {...testInstructions, ...packageInstructions}.toList();
  }

  Future<void> _pickAndUploadPrescription() async {
    final messenger = ScaffoldMessenger.of(context);
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['jpg', 'jpeg', 'png', 'pdf', 'webp'],
      withData: true,
    );

    final file = picked?.files.single;
    final path = file?.path;
    final bytes = file?.bytes;
    if ((path == null || path.isEmpty) && bytes == null) {
      messenger.showSnackBar(
        const SnackBar(
            content: Text('Please choose a valid prescription file')),
      );
      return;
    }

    setState(() {
      _uploadingPrescription = true;
    });

    try {
      final uploadedUrl = await ref.read(labServiceProvider).uploadPrescription(
            path ?? file?.name ?? 'prescription',
            fileBytes: bytes,
            fileName: file?.name,
          );

      if (!mounted) return;
      setState(() {
        _uploadingPrescription = false;
        _prescriptionUrl = uploadedUrl;
      });

      messenger.showSnackBar(
        const SnackBar(content: Text('Prescription uploaded successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _uploadingPrescription = false;
      });
      messenger.showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    }
  }

  Future<void> _bookLabOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedTestIds.isEmpty && _selectedPackageIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one test or package')),
      );
      return;
    }

    if (_totalAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Total amount must be greater than zero')),
      );
      return;
    }

    // Get test and package names for display
    final testNames = _catalog!.tests
        .where((t) => _selectedTestIds.contains(t.id))
        .map((t) => t.name)
        .toList();

    final packageNames = _catalog!.packages
        .where((p) => _selectedPackageIds.contains(p.id))
        .map((p) => p.name)
        .toList();

    if (!mounted) return;

    // Navigate to payment screen with booking details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LabPaymentScreen(
          labId: widget.labId,
          labName: _catalog!.lab.name,
          amount: _totalAmount,
          selectedTestIds: _selectedTestIds.toList(),
          selectedPackageIds: _selectedPackageIds.toList(),
          patientName: _nameController.text.trim(),
          patientAge: int.parse(_ageController.text.trim()),
          patientGender: _gender,
          relationship: _relationshipController.text.trim().isEmpty
              ? null
              : _relationshipController.text.trim(),
          prescriptionUrl: _prescriptionUrl,
          slotDate: _slotDate,
          slotTime: _slotTimeController.text.trim(),
          homeCollection: _homeCollection,
          address: _addressController.text.trim(),
          testNames: testNames,
          packageNames: packageNames,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_catalog == null) {
      return const Scaffold(
        body: Center(child: Text('Lab catalog not found')),
      );
    }

    final instructions = _preparationInstructions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Tests - ${_catalog!.lab.name}'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(UIConstants.spacingLarge),
          children: <Widget>[
            Text('Select Tests',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: UIConstants.spacingSmall),
            ..._catalog!.tests.map((test) {
              final selected = _selectedTestIds.contains(test.id);
              return CheckboxListTile(
                value: selected,
                title: Text(test.name),
                subtitle: Text('₹${test.effectivePrice.toStringAsFixed(0)}'),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedTestIds.add(test.id);
                    } else {
                      _selectedTestIds.remove(test.id);
                    }
                  });
                },
              );
            }),
            const SizedBox(height: UIConstants.spacingMedium),
            Text('Select Packages',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: UIConstants.spacingSmall),
            ..._catalog!.packages.map((pkg) {
              final selected = _selectedPackageIds.contains(pkg.id);
              return CheckboxListTile(
                value: selected,
                title: Text(pkg.name),
                subtitle: Text('₹${pkg.effectivePrice.toStringAsFixed(0)}'),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedPackageIds.add(pkg.id);
                    } else {
                      _selectedPackageIds.remove(pkg.id);
                    }
                  });
                },
              );
            }),
            const SizedBox(height: UIConstants.spacingMedium),
            Text('Patient Profile',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: UIConstants.spacingSmall),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Patient Name'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: UIConstants.spacingSmall),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
              validator: (v) {
                final age = int.tryParse(v ?? '');
                if (age == null || age < 0 || age > 120) {
                  return 'Enter valid age';
                }
                return null;
              },
            ),
            const SizedBox(height: UIConstants.spacingSmall),
            DropdownButtonFormField<String>(
              initialValue: _gender,
              decoration: const InputDecoration(labelText: 'Gender'),
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _gender = value;
                });
              },
            ),
            const SizedBox(height: UIConstants.spacingSmall),
            TextFormField(
              controller: _relationshipController,
              decoration:
                  const InputDecoration(labelText: 'Relationship (optional)'),
            ),
            const SizedBox(height: UIConstants.spacingMedium),
            Text('Collection Details',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            SwitchListTile(
              value: _homeCollection,
              title: const Text('Home collection'),
              onChanged: (value) {
                setState(() {
                  _homeCollection = value;
                });
              },
            ),
            const SizedBox(height: UIConstants.spacingSmall),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Slot Date'),
              subtitle: Text(
                  '${_slotDate.year}-${_slotDate.month.toString().padLeft(2, '0')}-${_slotDate.day.toString().padLeft(2, '0')}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 60)),
                  initialDate: _slotDate,
                );
                if (picked != null) {
                  setState(() {
                    _slotDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: UIConstants.spacingSmall),
            TextFormField(
              controller: _slotTimeController,
              decoration: const InputDecoration(
                  labelText: 'Slot Time (example: 09:00 AM)'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: UIConstants.spacingSmall),
            TextFormField(
              controller: _addressController,
              maxLines: 2,
              decoration:
                  const InputDecoration(labelText: 'Collection Address'),
              validator: (v) => (v == null || v.trim().length < 5)
                  ? 'Enter valid address'
                  : null,
            ),
            const SizedBox(height: UIConstants.spacingMedium),
            Text('Prescription (Optional)',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: UIConstants.spacingSmall),
            OutlinedButton.icon(
              onPressed:
                  _uploadingPrescription ? null : _pickAndUploadPrescription,
              icon: _uploadingPrescription
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.upload_file),
              label: Text(_prescriptionUrl == null
                  ? 'Upload Prescription'
                  : 'Re-upload Prescription'),
            ),
            if (_prescriptionUrl != null) ...<Widget>[
              const SizedBox(height: UIConstants.spacingSmall),
              Text(
                'Prescription uploaded',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: Colors.green[700]),
              ),
            ],
            const SizedBox(height: UIConstants.spacingMedium),
            if (instructions.isNotEmpty) ...<Widget>[
              Text('Preparation Instructions',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: UIConstants.spacingSmall),
              ...instructions.map((line) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('• '),
                        Expanded(child: Text(line)),
                      ],
                    ),
                  )),
              const SizedBox(height: UIConstants.spacingMedium),
            ],
            Container(
              padding: const EdgeInsets.all(UIConstants.spacingMedium),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(UIConstants.radiusMedium),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    '₹${_totalAmount.toStringAsFixed(0)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: UIConstants.spacingLarge),
            ElevatedButton(
              onPressed: _bookLabOrder,
              child: const Text('Confirm Booking & Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
