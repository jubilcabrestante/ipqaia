import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  List<Map<String, String>> personnelList = [];
  List<Map<String, String>> filteredAccounts = [];

  String? selectedCampus;
  final List<String> campuses = [
    "Select Campus",
    "Main Campus",
    "El Nido Campus",
    "Taytay Campus"
  ];

  @override
  void initState() {
    super.initState();
    personnelList = [
      {
        "Name": "John Doe",
        "Gender": "Male",
        "Civil Status": "Single",
        "Program/Course": "BSIT",
        "Student ID No.": "2023-00001",
        "Year Enrolled": "2025",
        "Date of Birth": "01-15-2022",
        "Indigenous Group": "No",
        "PWD": "No",
        "Financial Assistance": "No",
        "Campus": "Main Campus"
      },
    ];
    filteredAccounts = List.from(personnelList);
  }

  void _filterByCampus(String? campus) {
    setState(() {
      selectedCampus = campus;
      if (campus == null || campus == "Select Campus") {
        filteredAccounts = List.from(personnelList);
      } else {
        filteredAccounts = personnelList
            .where((personnel) => personnel["Campus"] == campus)
            .toList();
      }
    });
  }

  void _showAddPersonnelDialog() {
  final _formKey = GlobalKey<FormState>();
  List<String> genderOptions = ["Male", "Female", "Other"];
  List<String> civilStatusOptions = ["Single", "Married", "Divorced", "Widowed"];
  List<String> indigenousGroupOptions = ["No", "Yes"];
  List<String> pwdOptions = ["Yes", "No"];
  List<String> financialAssistanceOptions = ["Yes", "No"];

  Map<String, String> newStudent = {
    "Name": "",
    "Gender": genderOptions.first,
    "Civil Status": civilStatusOptions.first,
    "Program/Course": "",
    "Student ID No.": "",
    "Year Enrolled": "",
    "Date of Birth": "",
    "Indigenous Group": indigenousGroupOptions.first,
    "PWD": pwdOptions.first,
    "Financial Assistance": financialAssistanceOptions.first,
    "Campus": selectedCampus ?? "Main Campus",  // Default to selectedCampus or Main Campus
  };

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Add New Student"),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  onChanged: (value) => newStudent["Name"] = value,
                  validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Date Birth (MM-DD-YYYY)"),
                  onChanged: (value) => newStudent["Date of Birth"] = value,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                    _DateInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required';
                    final RegExp dateRegex = RegExp(r'^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])-\d{4}$');
                    return dateRegex.hasMatch(value) ? null : 'Enter a valid date (MM-DD-YYYY)';
                  },
                  
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Gender"),
                  value: newStudent["Gender"],
                  items: genderOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => newStudent["Gender"] = value as String),
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Civil Status"),
                  value: newStudent["Civil Status"],
                  items: civilStatusOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => newStudent["Civil Status"] = value as String),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Program/Course"),
                  onChanged: (value) => newStudent["Program/Course"] = value,
                  validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Student ID No."),
                  onChanged: (value) => newStudent["Student ID No."] = value,
                  validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Year Enrolled."),
                  onChanged: (value) => newStudent["Year Enrolled"] = value,
                  validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Indigenous Group"),
                  value: newStudent["Indigenous Group"],
                  items: indigenousGroupOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => newStudent["Indigenous Group"] = value as String),
                ),
                
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "PWD"),
                  value: newStudent["PWD"],
                  items: pwdOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => newStudent["PWD"] = value as String),
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: "Financial Assistance"),
                  value: newStudent["Financial Assistance"],
                  items: financialAssistanceOptions.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => newStudent["Financial Assistance"] = value as String),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Campus"),
                  value: newStudent["Campus"],
                  items: campuses.map((campus) {
                    return DropdownMenuItem<String>(
                      value: campus,
                      child: Text(campus),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => newStudent["Campus"] = value!),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                personnelList.add(newStudent);
                _filterByCampus(selectedCampus);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Student "${newStudent["Name"]}" added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: const Text("Add", style: TextStyle(color: Colors.green)),
        ),
      ],
    ),
  );
}

  void _deletePersonnel(int index) {
    final studentName = filteredAccounts[index]["Name"] ?? "this student";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete $studentName?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() {
                Map<String, String> toRemove = filteredAccounts[index];
                personnelList.remove(toRemove);
                _filterByCampus(selectedCampus);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$studentName deleted successfully.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        title: Padding(
          padding: const EdgeInsets.only(top: 3.0), // lowered position
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
  width: 300,
  child: DropdownButtonFormField<String>(
    value: selectedCampus ?? campuses.first,
    decoration: InputDecoration(
      labelText: "Select PSU Campus",
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    ),
    items: campuses.map((campus) {
      return DropdownMenuItem<String>(
        value: campus,
        child: Text(
          campus,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }).toList(),
    onChanged: _filterByCampus,
  ),
),

              AppCustomButton(
                ontab: _showAddPersonnelDialog,
                backgroundColor: const Color(0xFFFF502D),
                text: "Add New Student",
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 25,
                  headingRowColor: WidgetStateProperty.all(AppColors.primary),
                  headingTextStyle: context.textTheme.titleSmall!.copyWith(color: AppColors.textSecondary),
                  columns: [
                    "Full Name",
                    "Gender",
                    "Civil Status",
                    "Program/Course",
                    "Student ID No.",
                    "Year Enrolled",
                    "Date of Birth",
                    "Indigenous Group",
                    "PWD",
                    "Financial Assistance",
                    "Actions"
                  ].map((col) => DataColumn(label: Center(child: Text(col)))).toList(),
                  rows: filteredAccounts.map((personnel) {
                    int index = filteredAccounts.indexOf(personnel);
                    return DataRow(
                      cells: [
                        DataCell(Center(child: Text(personnel["Name"] ?? ""))),
                        DataCell(Center(child: Text(personnel["Gender"] ?? ""))),
                        DataCell(Center(child: Text(personnel["Civil Status"] ?? ""))),
                        DataCell(Center(child: Text(personnel["Program/Course"] ?? ""))),
                        DataCell(Center(child: Text(personnel["Student ID No."] ?? ""))),
                        DataCell(Center(child: Text(personnel["Year Enrolled"] ?? ""))),
                        DataCell(Center(child: Text(personnel["Date of Birth"] ?? ""))),
                        DataCell(Center(child: Text(personnel["Indigenous Group"] ?? ""))),
                        DataCell(Center(child: Text(personnel["PWD"] ?? ""))),
                        DataCell(Center(child: Text(personnel["Financial Assistance"] ?? ""))),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deletePersonnel(index),
                          ),
                        ),
                      ],
                    );
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

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 2) text = text.substring(0, 2) + '-' + text.substring(2);
    if (text.length > 5) text = text.substring(0, 5) + '-' + text.substring(5);
    if (text.length > 10) text = text.substring(0, 10);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
