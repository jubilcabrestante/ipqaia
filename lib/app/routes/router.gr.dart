// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:ipqaia/app/app_viewer.dart' as _i5;
import 'package:ipqaia/features/main/account_creation/presentation/account_screen.dart'
    as _i2;
import 'package:ipqaia/features/main/personel_profile/presentation/personel_profile.dart'
    as _i6;
import 'package:ipqaia/features/onboarding/login/presentation/change_password.dart'
    as _i1;
import 'package:ipqaia/features/onboarding/login/presentation/forgotpasswor.dart'
    as _i3;
import 'package:ipqaia/features/onboarding/login/presentation/login_screen.dart'
    as _i4;

/// generated route for
/// [_i1.ChangePassword]
class ChangePassword extends _i7.PageRouteInfo<void> {
  const ChangePassword({List<_i7.PageRouteInfo>? children})
    : super(ChangePassword.name, initialChildren: children);

  static const String name = 'ChangePassword';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChangePassword();
    },
  );
}

/// generated route for
/// [_i2.CreateAccountScreen]
class CreateAccountRoute extends _i7.PageRouteInfo<void> {
  const CreateAccountRoute({List<_i7.PageRouteInfo>? children})
    : super(CreateAccountRoute.name, initialChildren: children);

  static const String name = 'CreateAccountRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.CreateAccountScreen();
    },
  );
}

/// generated route for
/// [_i3.ForgotPasswordPage]
class ForgotPasswordRoute extends _i7.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i7.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.ForgotPasswordPage();
    },
  );
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.MainAppScreen]
class MainAppRoute extends _i7.PageRouteInfo<void> {
  const MainAppRoute({List<_i7.PageRouteInfo>? children})
    : super(MainAppRoute.name, initialChildren: children);

  static const String name = 'MainAppRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainAppScreen();
    },
  );
}

/// generated route for
/// [_i6.PersonelProfileScreen]
class PersonelProfileRoute extends _i7.PageRouteInfo<void> {
  const PersonelProfileRoute({List<_i7.PageRouteInfo>? children})
    : super(PersonelProfileRoute.name, initialChildren: children);

  static const String name = 'PersonelProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.PersonelProfileScreen();
    },
  );
}
