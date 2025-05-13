import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CopcScreen extends StatefulWidget {
  const CopcScreen({super.key});

  @override
  State<CopcScreen> createState() => _CopcScreenState();
}

class _CopcScreenState extends State<CopcScreen> {
  final List<Map<String, String>> copcData = [
    {
      'program': 'BS in Information Technology',
      'year': '2001',
      'copc': 'COPC-00123',
      'recommendation': 'IT_COPC.pdf',
      'supportDocs': 'IT_Review.docx',
      'status': 'Active',
    },
    {
      'program': 'BS in Civil Engineering',
      'year': '1998',
      'copc': 'COPC-00456',
      'recommendation': 'CE_COPC.pdf',
      'supportDocs': 'CE_Review.docx, CE_Curriculum.pdf',
      'status': 'Under Review',
    },
  ];

  final List<PlatformFile> supportingDocuments = [];
  String selectedCampus = '';
  final List<String> campuses = ['Main', 'East', 'West'];

  void _showAddDialog() {
    final TextEditingController programCtrl = TextEditingController();
    final TextEditingController yearCtrl = TextEditingController();
    final TextEditingController copcCtrl = TextEditingController();
    final TextEditingController statusCtrl = TextEditingController();
    PlatformFile? recommendationFile;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Center(
              child: Text("Add Document",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _textField(programCtrl, "Undergraduate Programs Offered:"),
                  _textField(yearCtrl, "Year of Initial Operation:"),
                  _textField(copcCtrl, "COPC number:"),
                  const SizedBox(height: 10),
                  _fileButton(
                    label: "Choose Recommendation File",
                    onFilePicked: (file) => recommendationFile = file,
                  ),
                  const SizedBox(height: 10),
                  ..._buildSupportingFileButtons(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: _addSupportingFile,
                        icon: const Icon(Icons.add, color: Colors.green),
                      ),
                    ],
                  ),
                  _textField(statusCtrl, "Status:"),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  copcData.add({
                    'program': programCtrl.text,
                    'year': yearCtrl.text,
                    'copc': copcCtrl.text,
                    'recommendation': recommendationFile?.name ?? 'No file',
                    'supportDocs':
                        supportingDocuments.map((f) => f.name).join(', '),
                    'status': statusCtrl.text,
                  });
                  supportingDocuments.clear();
                });
                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Upload"),
            ),
          ],
        );
      },
    );
  }

  Widget _textField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _fileButton({
    required String label,
    required Function(PlatformFile) onFilePicked,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles();
          if (result != null) {
            onFilePicked(result.files.first);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(label, style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  List<Widget> _buildSupportingFileButtons() {
    return List.generate(supportingDocuments.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Expanded(child: Text(supportingDocuments[index].name)),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  supportingDocuments.removeAt(index);
                });
              },
            ),
          ],
        ),
      );
    });
  }

  void _addSupportingFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        supportingDocuments.add(result.files.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('COPC List')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
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
                    DataColumn(
                        label: Text('Undergraduate Programs Offered')),
                    DataColumn(label: Text('Year of Initial Operation')),
                    DataColumn(label: Text('COPC Number')),
                    DataColumn(label: Text('Recommendation')),
                    DataColumn(label: Text('Supporting Documents')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: copcData.map((data) {
                    return DataRow(cells: [
                      DataCell(Text(data['program'] ?? '')),
                      DataCell(Text(data['year'] ?? '')),
                      DataCell(Text(data['copc'] ?? '')),
                      DataCell(Text(data['recommendation'] ?? '')),
                      DataCell(Text(data['supportDocs'] ?? '')),
                      DataCell(Text(data['status'] ?? '')),
                      DataCell(GestureDetector(
                        onTap: () {
                          setState(() {
                            copcData.remove(data);
                          });
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
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
}
