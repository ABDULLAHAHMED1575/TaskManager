import 'package:flutter/material.dart';

class MyCustomForm extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool validate;

  const MyCustomForm({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        errorText: validate ? "This field is required" : null,
      ),
    );
  }
}