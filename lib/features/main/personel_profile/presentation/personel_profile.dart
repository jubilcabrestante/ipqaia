import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PersonnelProfileScreen extends StatelessWidget {
  const PersonnelProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personnel Profile',
      home: PersonnelProfilePage(),
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
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Personnel Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                _buildTabButton('Profile', true),
                SizedBox(width: 10),
                _buildTabButton('Reports', false),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                  ),
                  child: Text('Add Profile',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: showProfile ? _buildProfileTable() : _buildReportsTable(),
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
      child: Text(title, style: TextStyle(color: Colors.black)),
    );
  }

Widget _buildProfileTable() {
  return Expanded(
    
    child: Scrollbar( // ✅ Adds Scrollbar for horizontal scrolling
      controller: ScrollController(), // Ensures smooth scrolling
       thumbVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // ✅ Enables left-to-right scrolling
        child: Scrollbar(
          controller: ScrollController(), // ✅ Adds vertical scrollbar too
          thumbVisibility: true,
          child: DataTable(
            columnSpacing: 20,
            headingRowColor: WidgetStateColor.resolveWith(
                (states) => Colors.orange.shade400),
            columns: const [
              DataColumn(
                  label: Text('Name', style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Gender', style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Civil Status',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Employment Status',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Date Started',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Department',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Degree', style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Specialization',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Date Started',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Department',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Degree', style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Specialization',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('PWD', style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Senior Citizen',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Action', style: TextStyle(color: Colors.white))),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(Text('Juan Dela Cruz')),
                const DataCell(Text('Male')),
                const DataCell(Text('Single')),
                const DataCell(Text('Permanent')),
                const DataCell(Text('June 20, 2024')),
                const DataCell(Text('CSD')),
                const DataCell(Text('Masters')),
                const DataCell(Text('Data Analyst')),
                     const DataCell(Text('June 20, 2024')),
            const DataCell(Text('CSD')),
            const DataCell(Text('Masters')),
            const DataCell(Text('Data Analyst')),
            const DataCell(Text('Yes')),
            const DataCell(Text('No')),
            DataCell(
              ElevatedButton(
                onPressed: ()  {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ),
              ]),
            ],
          ),
      
    ),
      ),
    ),
  );
  
  }

  Widget _buildReportsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.orange.shade400),
        columns: [
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
          DataColumn(label: Text('PWD', style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Senior Citizen',
                  style: TextStyle(color: Colors.white))),
          DataColumn(
              label: Text('Action', style: TextStyle(color: Colors.white))),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('June 20, 2024')),
            DataCell(Text('CSD')),
            DataCell(Text('Masters')),
            DataCell(Text('Data Analyst')),
            DataCell(Text('Yes')),
            DataCell(Text('No')),
            DataCell(
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
