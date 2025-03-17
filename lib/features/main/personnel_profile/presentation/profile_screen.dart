import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 68,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.orange.shade400),
        columns: [
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
        rows: [
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
}
