import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSearchPressed;
  final ValueChanged<String>? onSubmitted;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onSearchPressed,
    this.onSubmitted, required void Function(String query) onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(35),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        style: context.textTheme.bodyLarge?.copyWith(
          color: AppColors.textPrimary,
        ),
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: "Search here...",
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearchPressed,
          ),
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
