import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/button.dart';
import '../../data/languages.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({super.key});

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
  final Map<String, TextEditingController> _controllers = {
    'fullName': TextEditingController(),
    'gender': TextEditingController(),
    'year': TextEditingController(),
    'major': TextEditingController(),
    'labs': TextEditingController(),
    'generation': TextEditingController(),
    'phoneNumber': TextEditingController(),
    'purpose': TextEditingController(),
    'startDate': TextEditingController(),
    'endDate': TextEditingController(),
  };

  String? selectedGender;
  String? selectedYear;
  String? selectedLab;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        controller.text = DateFormat('MMM dd, yyyy').format(selectedDate);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Function to handle form submission
  void _submitForm() {
    final fullName = _controllers['fullName']!.text;
    final generation = _controllers['generation']!.text;
    final phoneNumber = _controllers['phoneNumber']!.text;
    final purpose = _controllers['purpose']!.text;
    final major = _controllers['major']!.text;
    final startDateText = _controllers['startDate']!.text;
    final endDateText = _controllers['endDate']!.text;

    if (selectedGender == null ||
        selectedYear == null ||
        selectedLab == null ||
        fullName.isEmpty ||
        generation.isEmpty ||
        phoneNumber.isEmpty ||
        purpose.isEmpty ||
        major.isEmpty ||
        startDateText.isEmpty ||
        endDateText.isEmpty) {
      // Show error message if any required field is empty or not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Convert date strings to DateTime objects
    final startDate = DateFormat('MMM dd, yyyy').parse(startDateText);
    final endDate = DateFormat('MMM dd, yyyy').parse(endDateText);

    // Check if startDate is after endDate
    if (startDate.isAfter(endDate)) {
      // Show error message if start date is after end date
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Start date cannot be after end date.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lab request submitted successfully!'),
        duration: Duration(seconds: 3),
      ),
    );

    // Clear form fields
    _controllers.forEach((key, controller) {
      controller.clear();
    });
    setState(() {
      selectedGender = null;
      selectedYear = null;
      selectedLab = null;
      selectedDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(Languages());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'permission.title'.tr,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[500]),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Full Name
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "",
                    labelText: "labRequest.name".tr,
                    controller: _controllers['fullName'],
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 10),
                // Gender Dropdown
                Expanded(
                  child: _buildDropdown(
                    label: 'labRequest.gender'.tr,
                    value: selectedGender,
                    items: [
                      'labRequest.genderMale'.tr,
                      'labRequest.genderFemale'.tr,
                      'labRequest.genderOther'.tr
                    ],
                    onChanged: (value) =>
                        setState(() => selectedGender = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Generation
            MyTextField(
              hintText: "",
              labelText: "labRequest.generation".tr,
              controller: _controllers['generation'],
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            // Year Dropdown
            _buildDropdown(
              label: 'labRequest.year'.tr,
              value: selectedYear,
              items: const ['1', '2', '3', '4', '5'],
              onChanged: (value) => setState(() => selectedYear = value),
            ),
            const SizedBox(height: 10),
            // Phone number
            MyTextField(
              hintText: "",
              labelText: "labRequest.phone".tr,
              controller: _controllers['phoneNumber'],
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            // Major
            MyTextField(
              hintText: "",
              labelText: "labRequest.major".tr,
              controller: _controllers['major'],
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            // Purpose
            MyTextField(
              hintText: "",
              labelText: "permission.reason".tr,
              controller: _controllers['reason'],
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            // Start Date and End Date
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "",
                    labelText: "labRequest.startDate".tr,
                    controller: _controllers['startDate'],
                    isRead: true,
                    onTap: () =>
                        _selectDate(context, _controllers['startDate']!),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MyTextField(
                    hintText: "",
                    labelText: "labRequest.endDate".tr,
                    controller: _controllers['endDate'],
                    isRead: true,
                    onTap: () => _selectDate(context, _controllers['endDate']!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Submit Button
            Row(
              children: [
                Expanded(
                  child: Button(
                    buttonText: "labRequest.button".tr,
                    backgroundColor: Colors.blue[50],
                    func: _submitForm,
                    textColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Function()? onTap;
  final bool? isRead;
  final TextInputType? keyboardType;

  const MyTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.onTap,
    this.isRead,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        keyboardType: keyboardType,
        readOnly: isRead ?? false,
        onTap: onTap,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              fontFamily: 'Poppins', fontSize: 16, color: Colors.grey[700]),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontFamily: 'Poppins', fontSize: 14, color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
