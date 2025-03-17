import 'package:auto_route/auto_route.dart';
import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(page: LoginRoute.page, path: '/', initial: true),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: MainAppRoute.page, path: '/', children: [
          //Dashboard
          AutoRoute(page: DashboardRoute.page, path: "dashboard"),

          // Academic Offerings
          AutoRoute(
              page: AcademicOfferingsRoute.page,
              path: "academic-offerings",
              children: []),

          // Accreditations
          AutoRoute(
              page: AccreditationRoute.page,
              path: "accreditation-route",
              children: []),

          // Student Life and Facilities
          AutoRoute(
              page: StudentLifeRoute.page,
              path: "student-life-and-facilities",
              children: []),

          //PersonnelProfileRoute
          AutoRoute(page: PersonnelProfileRoute.page, path: "personel-profile"),

          // Sustainable Development Goals
          AutoRoute(page: SdgRoute.page, path: "sdg"),

          //Accounts
          AutoRoute(page: AccountRoute.page, path: "accounts"),
        ]),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
