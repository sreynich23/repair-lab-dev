import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/textfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.question_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  MyTextField(
                    controller: _usernameController,
                    hintText: '',
                    labelText: 'Username',
                    keyboardType: TextInputType.text,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: _emailController,
                    hintText: 'example@gmail.com',
                    labelText: 'Email',
                    backgroundColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: _passwordController,
                    hintText: 'Enter password',
                    labelText: 'Password',
                    obscureText: true,
                    backgroundColor: Colors.white,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Button(
                          func: () {
                            submitHandle(context);
                          },
                          buttonText: "Register",
                          backgroundColor: Colors.blue[300],
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 250),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login/', (route) => false);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitHandle(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;

    if (username.isEmpty) {
      showSnackbar(context, 'Please enter your username');
    } else if (email.isEmpty) {
      showSnackbar(context, 'Please enter your email');
    } else if (password.length <= 6) {
      showSnackbar(context, 'Password must be at least 7 characters long');
    } else if (!_usernameContainsLetters(username)) {
      showSnackbar(context, 'Username must contain letters');
    } else if (_usernameContainsNumbersOnly(username)) {
      showSnackbar(context, 'Username cannot contain only numbers');
    } else if (email.isEmpty || password.isEmpty || username.isEmpty) {
      showSnackbar(context, 'Please enter your information');
    } else {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'username': username,
          'email': email,
        });
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackbar(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackbar(context, 'The account already exists for that email.');
        } else {
          showSnackbar(context, e.message ?? 'An error occurred.');
        }
      }
    }
  }

  bool _usernameContainsLetters(String username) {
    return RegExp(r'[a-zA-Z]').hasMatch(username);
  }

  bool _usernameContainsNumbersOnly(String username) {
    return RegExp(r'^[0-9]+$').hasMatch(username);
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
