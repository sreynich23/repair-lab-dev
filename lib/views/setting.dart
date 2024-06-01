import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:repairing_lap_app/views/login.dart';
import 'package:repairing_lap_app/views/subpages/help_support.dart';
import 'package:repairing_lap_app/views/subpages/them.dart';

import '../components/button.dart';
import '../components/notificatino_bell.dart';
import 'subpages/language.dart';
import 'subpages/manage_profile.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        actions: const [NotificationBell(notificationCount: 1)],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProfileImage(),
              const SizedBox(height: 10),
              _buildProfileName(),
              const Divider(),
              const SizedBox(height: 10),
              SettingButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageProfileView()));
                },
                titleText: "Manage Profile",
              ),
              const SizedBox(height: 10),
              SettingButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LanguageView()));
                },
                titleText: "Languages",
              ),
              const SizedBox(height: 10),
              SettingButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThemeView()));
                },
                titleText: "Theme",
              ),
              const SizedBox(height: 10),
              SettingButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpSupportView()));
                },
                titleText: "Help & Support",
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Button(
                  buttonText: "Log Out",
                  func: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  },
                  backgroundColor: Colors.red[100],
                  textColor: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile.webp',
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileName() {
    String? name = FirebaseAuth.instance.currentUser!.displayName;
    return Center(
      child: Text(
        "${name}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final String titleText;
  final VoidCallback onTap;

  const SettingButton(
      {super.key, required this.titleText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10)),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleText,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
