// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Color? backgroundColor; 
  const MyTextField({
    Key? key,
     this.controller,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.backgroundColor, // Initialize backgroundColor property
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText ?? 'label',
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.grey[700]!,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey,
          ),
          border: InputBorder.none, // Remove border
          filled: true,
          fillColor: Colors.transparent, // Set transparent color
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
