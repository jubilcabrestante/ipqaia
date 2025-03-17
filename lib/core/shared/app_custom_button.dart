import 'package:flutter/material.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';

class AppCustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? ontab;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? child;
  const AppCustomButton(
      {super.key,
      this.text,
      this.ontab,
      this.backgroundColor,
      this.textColor,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: child ??
          Text(
            text ?? '',
            style: context.textTheme.bodyLarge,
          ),
    );
  }
}
