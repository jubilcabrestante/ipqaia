import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/routes/router.gr.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_containers/app_header_container.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class SdgScreen extends StatelessWidget {
  const SdgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        ListArticlesRoute(),
        ManageSdgRoute(),
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
                    text: "List of Articles",
                    isActive: tabsRouter.activeIndex == 0,
                  ),
                  const Gap(20),
                  AppCustomButton(
                    ontab: () {
                      tabsRouter.setActiveIndex(1);
                    },
                    text: "Manage SDG's",
                    isActive: tabsRouter.activeIndex == 1,
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

class ReportScreen {
  const ReportScreen();
}
