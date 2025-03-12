import 'package:flutter/material.dart';
import 'package:ipqaia/app/routes/router.dart';
import 'package:ipqaia/app/themes/themes.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      theme: AppThemes.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
