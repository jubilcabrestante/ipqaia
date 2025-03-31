import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';

class AppCustomLoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const AppCustomLoadingIndicator({
    super.key,
    this.size = 20.0,
    this.color = AppColors.backgroundPrimary, // Default color is white
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
