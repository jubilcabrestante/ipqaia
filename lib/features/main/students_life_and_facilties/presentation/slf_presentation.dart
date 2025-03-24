import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/routes/router.gr.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_containers/app_header_container.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class StudentLifeScreen extends StatelessWidget {
  const StudentLifeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        StudentsRoute(),
        BuildingRoute(),
        DepartmentRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            centerTitle: false,
            title: AppHeaderContainer(
              child: Row(
                children: [
                  AppCustomButton(
                    ontab: () {
                      tabsRouter.setActiveIndex(0);
                    },
                    text: "Number of Students",
                    isActive: tabsRouter.activeIndex == 0,
                  ),
                  const Gap(20),
                  AppCustomButton(
                    ontab: () {
                      tabsRouter.setActiveIndex(1);
                    },
                    text: "Buildings",
                    isActive: tabsRouter.activeIndex == 1,
                  ),
                  const Gap(20),
                  AppCustomButton(
                    ontab: () {
                      tabsRouter.setActiveIndex(2);
                    },
                    text: "Departments",
                    isActive: tabsRouter.activeIndex == 2,
                  ),
                ],
              ),
            ),
          ),
          body: AppBodyContainer(child: child),
        );
      },
    );
  }
}
