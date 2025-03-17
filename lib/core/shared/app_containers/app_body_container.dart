import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
// import 'package:ipqaia/app/themes/colors.dart';

class AppBodyContainer extends StatelessWidget {
  final Widget? child;
  const AppBodyContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          border: Border(top: BorderSide(width: 0.5))),
      child: child,
    );
  }
}
