import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/languages.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedTheme;
    Get.put(Languages());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "themeView.themeViewTitle".tr,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[500]),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildDropdown(
          items: ['themeView.themeViewLight'.tr, 'themeView.themeViewDark'.tr],
          label: "themeView.themeViewDropdown".tr,
          onChanged: (value) {
            selectedTheme = value;
          },
          value: selectedTheme,
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
