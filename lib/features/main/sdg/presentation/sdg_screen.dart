import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_containers/app_header_container.dart';

@RoutePage()
class SdgScreen extends StatefulWidget {
  const SdgScreen({super.key});

  @override
  State<SdgScreen> createState() => _SdgScreenState();
}

class _SdgScreenState extends State<SdgScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: false,
        title: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppHeaderContainer(),
        ),
      ),
      body: AppBodyContainer(),
    );
  }
}
