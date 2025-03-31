import 'package:flutter/material.dart';

class AppCustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool obscure;
  final EdgeInsetsGeometry? padding;
  final String? Function(String?)? validator;

  const AppCustomTextfield({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    this.padding,
    this.obscure = false,
    this.validator, // Added validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator, // Apply validation here
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
