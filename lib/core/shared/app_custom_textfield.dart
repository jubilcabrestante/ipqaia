import 'package:flutter/material.dart';

class AppCustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool obscure;
  final EdgeInsetsGeometry? padding;
  final String? type;
  final int? maxLines;
  final String? Function(String?)? validator;

  const AppCustomTextfield({
    super.key,
    this.type,
    required this.controller,
    this.hintText,
    required this.label,
    this.padding,
    this.obscure = false,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      keyboardType: type == 'number'
          ? TextInputType.number
          : type == 'email'
              ? TextInputType.emailAddress
              : type == 'phone'
                  ? TextInputType.phone
                  : TextInputType.text,
      maxLines: obscure ? 1 : maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
