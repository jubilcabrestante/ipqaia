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
    // TODO: Initialize properties here

    //     final userRepository = FirebaseUserRepository(googleSignIn);
    //  MultiRepositoryProvider(
    //         providers: [],
    //         child: MultiBlocProvider(
    //           providers: [
    //             BlocProvider(
    //               create: (context) => SubjectBloc(),
    //             ),
    //             BlocProvider(
    //               create: (context) => SubjectBloc(),
    //             ),
    //           ],
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      theme: AppThemes.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
