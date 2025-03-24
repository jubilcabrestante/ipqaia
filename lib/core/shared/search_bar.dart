import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(25), // Adjust as needed
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        style: context.textTheme.bodyLarge?.copyWith(
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: "Search here...",
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none, // Removes default border
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        onChanged: onChanged, // Calls Cubit when text changes
      ),
    );
  }
}
