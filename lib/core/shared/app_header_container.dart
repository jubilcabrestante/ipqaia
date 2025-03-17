// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';

class AppHeaderContainer extends StatelessWidget {
  final Widget? child;
  const AppHeaderContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundSecondary,
      height: 100,
      width: double.infinity,
      child: child,
    );
  }
}
