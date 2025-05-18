import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/features/main/accounts/presentation/list_of_accounts_screen.dart';
import 'package:ipqaia/features/main/personnel_profile/presentation/personel_profile.dart';
import 'package:ipqaia/features/main/personnel_profile/presentation/personnel_profile_screen.dart';

@RoutePage()
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  String selectedMenu = "Account"; // Default selected menu

  // 🔹 Navigation List
  final List<Map<String, dynamic>> navList = [
    {"title": "Dashboard", "icon": Icons.home},
    {"title": "Academic Offerings", "icon": Icons.school},
    {"title": "Accreditation and COPC", "icon": Icons.assignment},
    {"title": "Student Life and Facilities", "icon": Icons.people},
    {"title": "Personnel Profile", "icon": Icons.person},
    {"title": "SDG", "icon": Icons.public},
    {"title": "Account", "icon": Icons.account_circle},
    {"title": "Logout", "icon": Icons.exit_to_app},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar
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
                      return _buildMenuItem(
                        navList[index]["title"],
                        navList[index]["icon"],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Right Main Content
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  // 🔹 Build Main Content Based on Selected Menu
  Widget _buildMainContent() {
    switch (selectedMenu) {
      case "Account":
        return const ListOfAccountsScreen();
      case "Personnel Profile":
        return const PersonnelProfileScreen();
      default:
        return Center(
          child: Text(
            "$selectedMenu Page Coming Soon...",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  // 🔹 Build Sidebar Menu Item
  Widget _buildMenuItem(String title, IconData icon) {
    bool isSelected = selectedMenu == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenu = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
