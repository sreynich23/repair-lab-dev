import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedLan = 'en_US'.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settingView.settingViewLan'.tr,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[500]),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() => _buildDropdown(
              items: [
                'languageView.languageViewEn'.tr,
                'languageView.languageViewKh'.tr
              ],
              label: 'languageView.languageViewDropdown'.tr,
              onChanged: (value) {
                if (value == 'languageView.languageViewEn'.tr) {
                  selectedLan.value = 'en_US';
                  Get.updateLocale(const Locale('en', 'US'));
                } else if (value == 'languageView.languageViewKh'.tr) {
                  selectedLan.value = 'kh_KH';
                  Get.updateLocale(const Locale('kh', 'KH'));
                }
              },
              value: selectedLan.value == 'en_US'
                  ? 'languageView.languageViewEn'.tr
                  : 'languageView.languageViewKh'.tr,
            )),
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
