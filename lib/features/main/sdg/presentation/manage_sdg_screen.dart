import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ManageSdgScreen extends StatefulWidget {
  const ManageSdgScreen({super.key});

  @override
  State<ManageSdgScreen> createState() => _ManageSdgScreenState();
}

class _ManageSdgScreenState extends State<ManageSdgScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("manage");
  }
}
