import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
                    // context.router.push(const )
                  },
                  text: "List of Articles",
                ),
                Gap(20),
                AppCustomButton(
                  ontab: () {
                    // context.router.push(const )
                  },
                  text: "Manage SDG's",
                )
              ],
            ),
          ),
        ),
      ),
      body: AppBodyContainer(),
    );
  }
}
