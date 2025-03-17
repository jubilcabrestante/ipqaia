import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';

class AppCustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? ontab;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? child;
  final bool? isActive;

  const AppCustomButton({
    super.key,
    this.text,
    this.ontab,
    this.backgroundColor,
    this.textColor,
    this.child,
    this.isActive = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: isActive!
              ? AppColors.primary
              : backgroundColor ?? AppColors.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: child ??
            Text(
              text ?? '',
              style: context.textTheme.bodyLarge!.copyWith(
                color: textColor ?? AppColors.textSecondary,
              ),
            ),
      ),
    );
  }
}
