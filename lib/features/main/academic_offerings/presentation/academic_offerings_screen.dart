import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/routes/router.gr.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_containers/app_header_container.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class AcademicOfferingsScreen extends StatefulWidget {
  const AcademicOfferingsScreen({super.key});

  @override
  State<AcademicOfferingsScreen> createState() =>
      _AcademicOfferingsScreenState();
}

class _AcademicOfferingsScreenState extends State<AcademicOfferingsScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        AcademicOfferingsRoute(),
        ProgramsRoute(),
        AcademicReportsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            centerTitle: false,
            title: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppHeaderContainer(
                child: Row(
                  children: [
                    AppCustomButton(
                      ontab: () {
                        tabsRouter.setActiveIndex(0);
                      },
                      text: "Student Profile Data",
                      isActive: tabsRouter.activeIndex == 0,
                    ),
                    const Gap(20),
                    AppCustomButton(
                      ontab: () {
                        tabsRouter.setActiveIndex(1);
                      },
                      text: "Program Offered",
                      isActive: tabsRouter.activeIndex == 1,
                    ),
                    const Gap(20),
                    AppCustomButton(
                      ontab: () {
                        tabsRouter.setActiveIndex(2);
                      },
                      text: "Reports",
                      isActive: tabsRouter.activeIndex == 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: AppBodyContainer(
            child: child,
          ),
        );
      },
    );
  }
}
