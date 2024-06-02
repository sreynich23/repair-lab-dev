import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/button.dart';
import '../../data/languages.dart';

class ManageProfileView extends StatelessWidget {
  const ManageProfileView({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(Languages());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settingView.settingViewProfile'.tr,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[500]),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ProfileAvatar(),
            const SizedBox(height: 5),
            EditProfileButton(onPressed: () {}),
            const SizedBox(height: 10),
            ProfileTextField(labelText: 'labRequest.name'.tr),
            const SizedBox(height: 10),
            ProfileTextField(labelText: 'loginView.loginEmail'.tr),
            const SizedBox(height: 10),
            const ChangePasswordButton(),
            const SizedBox(
                height: 20), // Add some space before the submit button
            SubmitButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 60,
      backgroundImage: AssetImage('assets/images/profile.webp'),
    );
  }
}

class EditProfileButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditProfileButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: onPressed,
      child: Text('manageProfileView.mpvEdit'.tr),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String labelText;

  const ProfileTextField({required this.labelText, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) {
        // Handle text changes
      },
    );
  }
}

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              //
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text('manageProfileView.mpvChangePassword'.tr),
            ),
          ),
        ),
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Button(
        buttonText: 'manageProfileView.mpvButton'.tr,
        func: onPressed,
        backgroundColor: Colors.blue[100],
        textColor: Colors.blue[500],
      ),
    );
  }
}
