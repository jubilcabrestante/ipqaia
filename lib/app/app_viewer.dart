import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/routes/router.gr.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_containers/app_container.dart';
import 'package:ipqaia/core/shared/app_dialog.dart';
import 'package:ipqaia/gen/assets.gen.dart';

@RoutePage()
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  final List<Map<String, dynamic>> navList = [
    {"title": "Dashboard", "icon": Icons.home, "route": DashboardRoute()},
    {
      "title": "Academic Offerings",
      "icon": Icons.school,
      "route": AcademicOfferingsRoute()
    },
    {
      "title": "Accreditation and COPC",
      "icon": Icons.assignment,
      "route": AccreditationRoute()
    },
    {
      "title": "Student Life and Facilities",
      "icon": Icons.people,
      "route": StudentLifeRoute()
    },
    {
      "title": "Personnel Profile",
      "icon": Icons.person,
      "route": PersonnelProfileRoute()
    },
    {"title": "SDG", "icon": Icons.public, "route": SdgRoute()},
    {"title": "Account", "icon": Icons.account_circle, "route": AccountRoute()},
    {"title": "Logout", "icon": Icons.logout},
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      // Filter out null routes and cast to PageRouteInfo
      routes: navList
          .where((item) => item['route'] != null)
          .map((item) => item['route'] as PageRouteInfo)
          .toList(),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final activeIndex = tabsRouter.activeIndex;

        return Scaffold(
          body: Row(
            children: [
              // Sidebar Navigation
              Container(
                width: 300,
                color: AppColors.secondary,
                child: Column(
                  children: [
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.images.logo.path,
                          width: 65,
                          height: 65,
                        ),
                        Text(
                          "IPQAIA SYSTEM",
                          style: context.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        )
                      ],
                    ),
                    const Gap(20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: navList.length,
                        itemBuilder: (context, index) {
                          final isSelected = activeIndex == index;
                          final item = navList[index];

                          return GestureDetector(
                            // Check for route presence instead of title
                            onTap: () {
                              if (item['route'] == null) {
                                AppDialog.showLogoutDialog(context);
                              } else {
                                tabsRouter.setActiveIndex(index);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      item['icon'],
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      item['title'],
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              ),
              // Main Content
              Expanded(
                child: AppContainer(
                  // Safe to use activeIndex since routes are filtered in order
                  title: navList[tabsRouter.activeIndex]['title'],
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
