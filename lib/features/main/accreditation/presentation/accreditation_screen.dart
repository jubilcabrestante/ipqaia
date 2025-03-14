import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AccreditationScreen extends StatelessWidget {
  const AccreditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personnel Profile',
      home: AccreditationPage(),
    );
  }
}

class AccreditationPage extends StatefulWidget {
  const AccreditationPage({super.key});

  @override
  AccreditationPageState createState() => AccreditationPageState();
}

class AccreditationPageState extends State<AccreditationPage> {
  bool showProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Accreditation and COPC', style: TextStyle(color: Colors.black)),
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
                _buildTabButton('Accreditation', true),
                SizedBox(width: 10),
                _buildTabButton('COPC', false),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                  ),
                  child: Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _buildValiditySection(), // Added validity section here
                Expanded(
                  child: showProfile ? _buildProfileTable() : _buildReportsTable(),
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
        backgroundColor: showProfile == isProfile ? Colors.orange.shade400 : Colors.orange.shade100,
      ),
      child: Text(title, style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildValiditySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Validity of Accreditation",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            "(Ref. Accreditation Certificate)",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 10),
          Table(
            border: TableBorder.all(color: Colors.black, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Colors.grey),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Start Date\n(MMM-DD-YYYY)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "End Date\n(MMM-DD-YYYY)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Jan-01-2021")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Dec-31-2024")),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Oct-01-2022")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Sep-30-2023")),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.orange.shade400),
        columns: [
          DataColumn(label: Text('Undergraduate Programs Offered', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Year of Initial Operation', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Program Accreditation', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Employment Status', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Date Started', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Department', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Degree', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Specialization', style: TextStyle(color: Colors.white))),
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

  Widget _buildReportsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.orange.shade400),
        columns: [
          DataColumn(label: Text('Date Started', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Department', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Degree', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Specialization', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('PWD', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Senior Citizen', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Action', style: TextStyle(color: Colors.white))),
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
