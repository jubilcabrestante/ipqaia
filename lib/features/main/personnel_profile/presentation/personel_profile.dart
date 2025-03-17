import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/core/shared/app_containers/app_body_container.dart';
import 'package:ipqaia/core/shared/app_containers/app_header_container.dart';

@RoutePage()
class PersonnelProfileScreen extends StatelessWidget {
  const PersonnelProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personnel Profile',
      home: const PersonnelProfilePage(),
    );
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        centerTitle: false,
        title: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppHeaderContainer(),
        ),
      ),
      body: AppBodyContainer(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  _buildTabButton('Profile', true),
                  const SizedBox(width: 10),
                  _buildTabButton('Reports', false),
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
            const SizedBox(height: 1),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search article here...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 1),
            Row(
              children: [
                const Text(
                  'COLLEGE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 1),
                ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('College of Sciences'),
                ),
              ],
            ),
            Expanded(
              child: showProfile ? _buildProfileTable() : _buildReportsTable(),
            ),
          ],
        ),
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

  Widget _buildProfileTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.orange.shade400),
        columns: const [
          DataColumn(
              label: Text('Name', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Gender', style: TextStyle(color: Colors.white))),
          DataColumn(
              label:
                  Text('Civil Status', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Employment Status',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label:
                  Text('Date Started', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Department', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Degree', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Specialization',
                  style: TextStyle(color: Colors.white))),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('Juan Dela Cruz')),
            DataCell(Text('Male')),
            DataCell(Text('Single')),
            DataCell(Text('Permanent')),
            DataCell(Text('June 20, 2024')),
            DataCell(Text('CSD')),
            DataCell(Text('Masters')),
            DataCell(Text('Data Analyst')),
          ]),
        ],
      ),
    );
  }

  Widget _buildReportsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 100,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.orange.shade400),
        columns: const [
          DataColumn(
              label: Text('Department Name',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label:
                  Text('Date Started', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('With Bachelors Degree',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('With Masters Degree',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('With Doctorate',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('LGBTQ', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Senior Citizen',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label:
                  Text('Male/Female', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Number of Personnel',
                  style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('PWD', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Actions', style: TextStyle(color: Colors.white))),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(Text('bakla')),
            DataCell(
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
