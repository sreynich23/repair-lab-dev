import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                          buttonText: "Login",
                          backgroundColor: Colors.blue[300],
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 325),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/register/', (route) => false);
                    },
                    child: const Text(
                      "Register",
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

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackbar(context, 'Wrong password provided.');
      } else {
        showSnackbar(context, e.message ?? 'An error occurred.');
      }
    }
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
