import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/routes/router.gr.dart';

@RoutePage()
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  String selectedMenu = "Account"; // Default selected menu

  // Navigation List
  final List<Map<String, dynamic>> navList = [
    {
      "title": "Personnel Profile",
      "icon": Icons.person,
      "route": PersonnelProfileReportsRoute()
    },
    {
      "title": "Account",
      "icon": Icons.account_circle,
      "route": CreateAccountRoute()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar Navigation
          Container(
            width: 250,
            color: Colors.orange.shade200,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: navList.length,
                    itemBuilder: (context, index) {
                      final item = navList[index];
                      return ListTile(
                        title: Text(item["title"]),
                        leading: Icon(item["icon"]),
                        selected: selectedMenu == item["title"],
                        onTap: () {
                          setState(() {
                            selectedMenu = item["title"];
                          });
                          context.router.push(item["route"]);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Main Content Area (Right Side)
          Expanded(
            child: AutoRouter(),
          ),
        ],
      ),
    );
  }
}
