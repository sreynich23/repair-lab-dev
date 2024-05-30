import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function? func;
  final String buttonText;
  final Color? textColor;
  final Color? backgroundColor;

  const Button({
    super.key,
    this.func,
    required this.buttonText,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func as void Function()?,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: backgroundColor,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.25),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
          color: textColor ?? Colors.blue[900],
        ),
      ),
    );
  }
}
