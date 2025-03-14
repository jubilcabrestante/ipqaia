import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PersonnelProfileReportsScreen extends StatefulWidget {
  const PersonnelProfileReportsScreen({super.key});

  @override
  State<PersonnelProfileReportsScreen> createState() =>
      _PersonnelProfileReportsScreenState();
}

class _PersonnelProfileReportsScreenState
    extends State<PersonnelProfileReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personnel Profile Reports'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search personnel...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.redAccent),
                  columns: const [
                    DataColumn(
                        label: Text('Department name',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('Date started',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('With bachelors Degree',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('With Masters Degree',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('With Masters Degree',
                            style: TextStyle(color: Colors.white))),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text("")),
                      DataCell(Text('')),
                      DataCell(Text('')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text("")),
                      DataCell(Text('')),
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
