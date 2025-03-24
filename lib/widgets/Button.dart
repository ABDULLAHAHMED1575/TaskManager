import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon) : const SizedBox(),
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}