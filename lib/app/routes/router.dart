import 'package:auto_route/auto_route.dart';
import 'router.gr.dart';
// ignore: duplicate_import
import 'package:ipqaia/app/routes/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: MainAppRoute.page, path: '/main'),
        AutoRoute(page: CreateAccountRoute.page, path: '/account'),
        AutoRoute(page: PersonelProfileRoute.page, path: '/personelprofile'),
        AutoRoute(page: AccreditationRoute.page, path: '/personelprofile'),

        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: MainAppRoute.page, path: '/', children: [
          AutoRoute(
            page: CreateAccountRoute.page,
          ),
          AutoRoute(
            page: PersonelProfileRoute.page,
          ),
        ]),
        AutoRoute(
            page: PersonnelProfileReportsRoute.page,
            path: '/personnelprofilereports'),
                AutoRoute(page: ForgotPasswordRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
