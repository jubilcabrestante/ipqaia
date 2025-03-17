import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/routes/router.gr.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/app_container.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: navList.map((item) => item['route'] as PageRouteInfo).toList(),
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
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: navList.length,
                        itemBuilder: (context, index) {
                          final isSelected = activeIndex == index;

                          return GestureDetector(
                            onTap: () {
                              tabsRouter.setActiveIndex(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.deepOrange
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
                                      navList[index]['icon'],
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      navList[index]['title'],
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
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // Main Content
              Expanded(
                  child: AppContainer(
                title: navList[tabsRouter.activeIndex]['title'],
                child: child,
              )),
            ],
          ),
        );
      },
    );
  }
}
