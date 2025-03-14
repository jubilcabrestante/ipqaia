import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/routes/router.gr.dart';

@RoutePage()
class PersonelProfileScreen extends StatelessWidget {
  const PersonelProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PersonnelProfilePage();
  }
}

class PersonnelProfilePage extends StatefulWidget {
  const PersonnelProfilePage({super.key});

  @override
  PersonnelProfilePageState createState() => PersonnelProfilePageState();
}

class PersonnelProfilePageState extends State<PersonnelProfilePage> {
  bool showProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Personnel Profile',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                _buildTabButton('Profile', true),
                const SizedBox(width: 10),

                // 🔹 Fixed Navigation Button
                ElevatedButton(
                  onPressed: () {
                    context.router.push(const PersonnelProfileReportsRoute());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                  ),
                  child: const Text('Reports',
                      style: TextStyle(color: Colors.white)),
                ),

                const Spacer(),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                  ),
                  child: const Text('Add Profile',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isProfile) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          showProfile = isProfile;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: showProfile == isProfile
            ? Colors.orange.shade400
            : Colors.orange.shade100,
      ),
      child: Text(title, style: const TextStyle(color: Colors.black)),
    );
  }
}
