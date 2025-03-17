import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';

class AppDialog {
  static Future<void> showCustomAlertDialog(
    BuildContext context, // Directly use BuildContext instead of navigatorKey
    String title,
    String content, {
    String buttonText = 'OK',
    Color? buttonColor,
    Color? textColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
  }) {
    buttonColor ??= AppColors.primary;
    textColor ??= AppColors.textSecondary;

    final defaultTitleStyle = titleStyle ??
        TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        );

    final defaultContentStyle = contentStyle ??
        TextStyle(
          fontSize: 21,
        );

    // Show the dialog directly with the provided context
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: defaultTitleStyle, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text(content,
                    style: defaultContentStyle, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Close the dialog
                  },
                  child: Text(buttonText,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: SizedBox(
          width: 300, // Ensure a defined width
          child: Padding(
            padding: const EdgeInsets.all(30),
            // child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
            //   listener: (context, state) {
            //     if (state.isAuthenticated == false) {
            //       context.router.replaceAll([MainAppRoute()]);
            //     }
            //   },
            //   builder: (context, state) {
            //     final authCubit = context.read<AuthenticationCubit>();
            child: IntrinsicHeight(
              // Ensure the content is wrapped properly
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Important to prevent layout issues
                children: [
                  // Text(
                  //   "Log Out",
                  //   style: context
                  //       .textTheme
                  //       .titleLarge!s
                  //       .copyWith(fontWeight: FontWeight.bold),
                  // ),
                  Text(
                    "Are you sure you want to logout?",
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.backgroundPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundPrimary,
                          ),
                          child: Text(
                            "Log Out",
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          onPressed: () {
                            // authCubit.signOut();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//TODO: Add App dialog for the sdg entry and update
}
