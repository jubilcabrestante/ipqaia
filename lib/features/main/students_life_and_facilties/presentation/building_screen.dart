import 'dart:html' as html; // For downloading files (web)

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BuildingScreen extends StatefulWidget {
  const BuildingScreen({super.key});

  @override
  State<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends State<BuildingScreen> {
  final campuses = ['All', 'Main Campus', 'Engineering Campus'];
  String selectedCampus = 'All';

  final allBuildings = <Map<String, dynamic>>[
    {
      'id': '1',
      'name': 'COLLEGE OF SCIENCES',
      'campus': 'Main Campus',
      'classroom': 40,
      'lab': 30,
      'totalCapacity': 500,
      'yearConstructed': 2000,
      'yearCompleted': 2005,
      'document': 'CSbldg.pdf',
      'purpose': 'Science Education',
      'budget': '2M',
    },
    {
      'id': '3',
      'name': 'ENGINEERING COMPLEX',
      'campus': 'Engineering Campus',
      'classroom': 50,
      'lab': 40,
      'totalCapacity': 700,
      'yearConstructed': 2005,
      'yearCompleted': 2006,
      'document': 'Engrbldg.pdf',
      'purpose': 'Engineering Education',
      'budget': '3M',
    },
  ];

  List<Map<String, dynamic>> get filteredBuildings {
    if (selectedCampus == 'All') return allBuildings;
    return allBuildings.where((b) => b['campus'] == selectedCampus).toList();
  }

  void openAddBuildingDialog() async {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String purpose = '';
    String budget = '';
    int classroom = 0;
    int lab = 0;
    int totalCapacity = 0;
    int yearConstructed = DateTime.now().year;
    int yearCompleted = DateTime.now().year;
    String? documentName;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          titlePadding:
              const EdgeInsets.only(left: 24, top: 24, right: 8, bottom: 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Add Building"),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Building Name'),
                      onSaved: (val) => name = val ?? '',
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Classroom Capacity'),
                      keyboardType: TextInputType.number,
                      onSaved: (val) => classroom = int.parse(val!),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Lab Capacity'),
                      keyboardType: TextInputType.number,
                      onSaved: (val) => lab = int.parse(val!),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Total Capacity'),
                      keyboardType: TextInputType.number,
                      onSaved: (val) => totalCapacity = int.parse(val!),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Purpose'),
                      onSaved: (val) => purpose = val ?? '',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Budget'),
                      onSaved: (val) => budget = val ?? '',
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Year Constructed'),
                      keyboardType: TextInputType.number,
                      onSaved: (val) => yearConstructed =
                          int.tryParse(val!) ?? yearConstructed,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Year Completed'),
                      keyboardType: TextInputType.number,
                      onSaved: (val) =>
                          yearCompleted = int.tryParse(val!) ?? yearCompleted,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.attach_file),
                      label: Text(documentName ?? 'Select Document'),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          setState(() {
                            documentName = result.files.single.name;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  setState(() {
                    allBuildings.add({
                      'id': (allBuildings.length + 1).toString(),
                      'name': name,
                      'campus': selectedCampus == 'All'
                          ? 'Main Campus'
                          : selectedCampus,
                      'classroom': classroom,
                      'lab': lab,
                      'totalCapacity': totalCapacity,
                      'yearConstructed': yearConstructed,
                      'yearCompleted': yearCompleted,
                      'document': documentName ?? 'No file',
                      'purpose': purpose,
                      'budget': budget,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void downloadFile(String fileName) {
    final url = 'assets/$fileName'; // Assuming you have files under /assets/
    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
  }

  void confirmDelete(Map<String, dynamic> bldg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding:
              const EdgeInsets.only(left: 24, top: 24, right: 8, bottom: 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Confirm Delete'),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: Text('Are you sure you want to delete "${bldg['name']}"?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  allBuildings.remove(bldg);
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget buildHeader() {
    return Container(
      color: const Color(0xFFFF502D),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: const [
          Expanded(
              flex: 1,
              child: Text('Total Buildings',
                  style: TextStyle(color: Colors.white))),
          Expanded(
              flex: 3,
              child: Text('Name', style: TextStyle(color: Colors.white))),
          Expanded(
              flex: 5,
              child: Text('Capacity', style: TextStyle(color: Colors.white))),
          Expanded(
              flex: 2,
              child: Text('Year Constructed',
                  style: TextStyle(color: Colors.white))),
          Expanded(
              flex: 2,
              child: Text('Year Completed',
                  style: TextStyle(color: Colors.white))),
          Expanded(
              flex: 2,
              child: Text('Doc.', style: TextStyle(color: Colors.white))),
          Expanded(
              flex: 1,
              child: Text('Action', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget buildRow(Map<String, dynamic> bldg) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: Text(bldg['id'])),
              Expanded(flex: 3, child: Text(bldg['name'])),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Classroom Capacity: ${bldg['classroom']} students per room"),
                    Text(
                        "Laboratory Capacity: ${bldg['lab']} computers/workstations"),
                    Text("Total Building Capacity: ${bldg['totalCapacity']}"),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Text('${bldg['yearConstructed']}')),
              Expanded(flex: 2, child: Text('${bldg['yearCompleted']}')),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () => downloadFile(bldg['document']),
                  child: Text(
                    bldg['document'] ?? '',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () => confirmDelete(bldg),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 2, color: Colors.redAccent),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Building Information"),
        actions: [
          TextButton(
            onPressed: openAddBuildingDialog,
            child: const Text(
              "Add",
              style: TextStyle(backgroundColor: Colors.red, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Filter by Campus: '),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCampus,
                  items: campuses.map((campus) {
                    return DropdownMenuItem(
                      value: campus,
                      child: Text(campus),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedCampus = value);
                    }
                  },
                ),
              ],
            ),
          ),
          buildHeader(),
          Expanded(
            child: ListView(
              children: filteredBuildings.map(buildRow).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
