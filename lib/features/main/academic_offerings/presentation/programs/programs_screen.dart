import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/routes/router.gr.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  final List<Map<String, dynamic>> items = [
    {"title": 'PSU Main Campus', "route": ProgramsMainRoute()},
    {"title": 'PSU External Campus', "route": ProgramsExternalRoute()},
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: items.map((item) => item['route'] as PageRouteInfo).toList(),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.backgroundSecondary,
            title: Row(
              children: [
                ...List.generate(items.length, (index) {
                  final item = items[index];
                  final isSelected = tabsRouter.activeIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: AppCustomButton(
                      text: item['title'],
                      backgroundColor: isSelected ? AppColors.primary : null,
                      ontab: () {
                        tabsRouter.setActiveIndex(index);
                      },
                    ),
                  );
                }),
                const Spacer(),
                AppCustomButton(
                  text: 'Add Program',
                  ontab: () {
                    // TODO: Implement add student functionality
                  },
                ),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
