// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:ipqaia/app/app_viewer.dart' as _i3;
import 'package:ipqaia/features/onboarding/login/presentation/forgotpasswor.dart'
    as _i1;
import 'package:ipqaia/features/onboarding/login/presentation/login_screen.dart'
    as _i2;

/// generated route for
/// [_i1.ForgotPasswordPage]
class ForgotPasswordRoute extends _i4.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i4.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.MainAppScreen]
class MainAppRoute extends _i4.PageRouteInfo<void> {
  const MainAppRoute({List<_i4.PageRouteInfo>? children})
    : super(MainAppRoute.name, initialChildren: children);

  static const String name = 'MainAppRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainAppScreen();
    },
  );
}
