import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AcademicReportsScreen extends StatefulWidget {
  const AcademicReportsScreen({super.key});

  @override
  State<AcademicReportsScreen> createState() => _AcademicReportsScreenState();
}

class _AcademicReportsScreenState extends State<AcademicReportsScreen> {
  String? selectedCampus;
  String? selectedYearLevel;

  final List<String> campusOptions = ['PSU Main', 'External Campus'];
  final List<String> yearLevelOptions = ['1st Year', '2nd Year', '3rd Year', '4th Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Academic Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown filters
            Row(
              children: [
                const Text('Campus:'),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  hint: const Text('Select campus'),
                  value: selectedCampus,
                  items: campusOptions.map((campus) {
                    return DropdownMenuItem<String>(
                      value: campus,
                      child: Text(campus),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCampus = value;
                    });
                  },
                ),
                const SizedBox(width: 30),
                const Text('Year Level:'),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  hint: const Text('Select year level'),
                  value: selectedYearLevel,
                  items: yearLevelOptions.map((level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYearLevel = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Data Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.deepOrange),
                  headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  columns: const [
                    DataColumn(label: Text('Program Name')),
                    DataColumn(label: Text('No. of students\nenrolled in program')),
                    DataColumn(label: Text('No. of students\nin 1st Semester')),
                    DataColumn(label: Text('No. of students\nin 2nd Semester')),
                    DataColumn(label: Text('IP Students')),
                    DataColumn(label: Text('PWD Students')),
                    DataColumn(label: Text('Students with\nFinancial Assistance')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('BSIT')),
                      DataCell(Text('56')),
                      DataCell(Text('56')),
                      DataCell(Text('56')),
                      DataCell(Text('56')),
                      DataCell(Text('56')),
                      DataCell(Text('56')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
