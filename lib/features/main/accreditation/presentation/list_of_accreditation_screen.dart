import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

@RoutePage()
class ListOfAccreditationScreen extends StatefulWidget {
  const ListOfAccreditationScreen({super.key});

  @override
  State<ListOfAccreditationScreen> createState() => _ListOfAccreditationScreenState();
}

class _ListOfAccreditationScreenState extends State<ListOfAccreditationScreen> {
  String selectedCampus = '';
  final List<String> campuses = ['Main', 'East', 'West'];

  final List<Map<String, String>> accreditationData = [
    {
      'program': 'AB in Political Science',
      'year': '1998',
      'status': 'Level 3',
      'startDate': 'Jan-01-2021',
      'endDate': 'Dec-31-2024',
      'recommendation': 'PolSci.pdf',
      'supportDoc': 'AACCUP Technical Review.docx',
      'remarks': 'Requested deferment'
    },
    {
      'program': 'BS in Electrical Engineering',
      'year': '1981',
      'status': 'Level 3',
      'startDate': 'Oct-01-2022',
      'endDate': 'Sep-30-2023',
      'recommendation': 'EE.pdf',
      'supportDoc': 'AACCUP Technical Review.docx',
      'remarks': '3 years offered, non-accreditable'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accreditation List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('PSU Campus:  '),
                DropdownButton<String>(
                  hint: const Text('select campus'),
                  value: selectedCampus.isEmpty ? null : selectedCampus,
                  items: campuses.map((campus) {
                    return DropdownMenuItem<String>(
                      value: campus,
                      child: Text(campus),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCampus = value ?? '';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Undergraduate Programs Offered')),
                    DataColumn(label: Text('Year of Initial Operation')),
                    DataColumn(label: Text('Program Accreditation Status')),
                    DataColumn(label: Text('Start Date')),
                    DataColumn(label: Text('End Date')),
                    DataColumn(label: Text('Recommendation')),
                    DataColumn(label: Text('Supporting Document')),
                    DataColumn(label: Text('Remarks')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: accreditationData.map((data) {
                    return DataRow(cells: [
                      DataCell(Text(data['program'] ?? '')),
                      DataCell(Text(data['year'] ?? '')),
                      DataCell(Text(data['status'] ?? '')),
                      DataCell(Text(data['startDate'] ?? '')),
                      DataCell(Text(data['endDate'] ?? '')),
                      DataCell(Row(
                        children: [
                          const Icon(Icons.file_download, size: 16),
                          const SizedBox(width: 4),
                          Text(data['recommendation'] ?? ''),
                        ],
                      )),
                      DataCell(Row(
                        children: [
                          const Icon(Icons.file_download, size: 16),
                          const SizedBox(width: 4),
                          Text(data['supportDoc'] ?? ''),
                        ],
                      )),
                      DataCell(Text(data['remarks'] ?? '')),
                      DataCell(GestureDetector(
                        onTap: () {
                          setState(() {
                            accreditationData.remove(data);
                          });
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController programCtrl = TextEditingController();
    TextEditingController yearCtrl = TextEditingController();
    TextEditingController startDateCtrl = TextEditingController();
    TextEditingController endDateCtrl = TextEditingController();
    TextEditingController remarksCtrl = TextEditingController();
    PlatformFile? recommendation;
    PlatformFile? supportDoc;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Add Document", style: TextStyle(fontWeight: FontWeight.bold))),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: programCtrl,
                    decoration: const InputDecoration(labelText: "Undergraduate Programs Offered"),
                  ),
                  TextFormField(
                    controller: yearCtrl,
                    decoration: const InputDecoration(labelText: "Year of Initial Operation"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  const Text("Validity of Accreditation (Ref. Accreditation Certificate)"),
                  TextFormField(
                    controller: startDateCtrl,
                    decoration: const InputDecoration(labelText: "Start Date (mm/dd/yyyy)"),
                  ),
                  TextFormField(
                    controller: endDateCtrl,
                    decoration: const InputDecoration(labelText: "End Date (mm/dd/yyyy)"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        recommendation = result.files.first;
                      }
                    },
                    child: const Text("Choose Recommendation File"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        supportDoc = result.files.first;
                      }
                    },
                    child: const Text("Choose Supporting Document (Optional)"),
                  ),
                  TextFormField(
                    controller: remarksCtrl,
                    decoration: const InputDecoration(labelText: "Remarks"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    accreditationData.add({
                      'program': programCtrl.text,
                      'year': yearCtrl.text,
                      'status': 'Level 1', // Default or calculated value
                      'startDate': startDateCtrl.text,
                      'endDate': endDateCtrl.text,
                      'recommendation': recommendation?.name ?? 'No file',
                      'supportDoc': supportDoc?.name ?? '',
                      'remarks': remarksCtrl.text,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Upload"),
            ),
          ],
        );
      },
    );
  }
}
