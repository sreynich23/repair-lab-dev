import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/button.dart';

class ManageProfileView extends StatelessWidget {
  const ManageProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Profile",
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
            const ProfileTextField(labelText: 'Name'),
            const SizedBox(height: 10),
            const ProfileTextField(labelText: 'Email'),
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
      child: const Text("Edit Profile"),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ChangePasswordDialog();
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text("Change Password"),
            ),
          ),
        ),
      ],
    );
  }
}

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: const Text("You need to contact labs for change password"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () async {
                const url = 'https://t.me/repairinglab017';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
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
        buttonText: "Submit",
        func: onPressed,
        backgroundColor: Colors.blue[100],
        textColor: Colors.blue[500],
      ),
    );
  }
}
