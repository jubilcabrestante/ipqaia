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
  final double? width;
  final double? height;
  final double? padding;

  const AppCustomButton({
    super.key,
    this.width,
    this.padding,
    this.height,
    this.text,
    this.ontab,
    this.backgroundColor,
    this.textColor,
    this.child,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontab,
      child: Container(
        width: width,
        height: height,
        padding: padding != null
            ? EdgeInsets.all(padding!)
            : EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive!
              ? AppColors.primary
              : backgroundColor ?? AppColors.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(
          minWidth: 0, // Allows it to shrink to fit content
          minHeight: 0,
        ),
        child: child ??
            Text(
              text ?? '',
              style: context.textTheme.bodyMedium!.copyWith(
                color: textColor ?? AppColors.textSecondary,
              ),
            ),
      ),
    );
  }
}
