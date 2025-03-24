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
        AutoRoute(page: LoginRoute.page, path: '/', initial: true),
        AutoRoute(page: ForgotPasswordRoute.page, path: '/'),
        AutoRoute(page: MainAppRoute.page, path: '/', children: [
          //Dashboard
          AutoRoute(
              page: DashboardRoute.page, path: "dashboard", initial: true),

          // Academic Offerings
          AutoRoute(
              page: AcademicOfferingsRoute.page,
              path: "academic-offerings",
              children: [
                AutoRoute(
                    page: StudentProfileRoute.page, path: "student-profile"),
                AutoRoute(page: ProgramsRoute.page, path: "program"),
                AutoRoute(
                    page: AcademicReportsRoute.page, path: "academic-reports")
              ]),

          // Accreditations
          AutoRoute(
              page: AccreditationRoute.page,
              path: "accreditation-route",
              children: [
                AutoRoute(
                    page: ListOfAccreditationRoute.page,
                    path: "list-of-accounts"),
                AutoRoute(page: CopcRoute.page, path: "copc")
              ]),

          // Student Life and Facilities
          AutoRoute(
              page: StudentLifeRoute.page,
              path: "student-life-and-facilities",
              children: [
                AutoRoute(page: StudentsRoute.page, path: "students"),
                AutoRoute(page: BuildingRoute.page, path: "buildings"),
                AutoRoute(page: DepartmentRoute.page, path: "departments")
              ]),

          //PersonnelProfileRoute
          AutoRoute(
              page: PersonnelProfileRoute.page,
              path: "personnel-profile",
              children: [
                AutoRoute(page: ProfileRoute.page, path: "profile"),
                AutoRoute(page: ReportRoute.page, path: "reports")
              ]),

          // Sustainable Development Goals
          AutoRoute(page: SdgRoute.page, path: "sdg", children: [
            AutoRoute(page: ListArticlesRoute.page, path: "list-articles"),
            AutoRoute(page: ManageSdgRoute.page, path: "manage-sdg")
          ]),

          //Accounts
          AutoRoute(page: AccountRoute.page, path: "accounts", children: [
            AutoRoute(page: ListOfAccountsRoute.page, path: "list-of-accounts"),
            AutoRoute(page: CreateAccountRoute.page, path: "create-account")
          ]),
        ]),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
