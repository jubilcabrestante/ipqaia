import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipqaia/app/routes/router.dart';
import 'package:ipqaia/app/themes/themes.dart';
import 'package:ipqaia/features/main/sdg/domain/cubit/sdg_cubit.dart';
import 'package:ipqaia/features/main/sdg/domain/i_sdg_repository.dart';
import 'package:ipqaia/features/main/sdg/repository/sdg_repository.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    final sdgRepository = SdgRepository();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ISdgRepository>.value(value: sdgRepository),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => SdgCubit(sdgRepository))],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: true,
          theme: AppThemes.lightTheme,
          routerConfig: _appRouter.config(),
        ),
      ),
    );
  }
}
