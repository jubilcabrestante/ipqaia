import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';

class AppContainer extends StatelessWidget {
  final String? title;
  final Widget child;
  const AppContainer({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Text(title!),
      )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
        child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: Offset(1, 3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  color: AppColors.gray.withValues(alpha: 0.5)),
              BoxShadow(
                  offset: Offset(3, 1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  color: AppColors.gray.withValues(alpha: 0.5))
            ]),
            child: child),
      ),
    );
  }
}
