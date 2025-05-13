import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/search_bar.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> personnelList = [];
  List<Map<String, String>> filteredAccounts = [];

  @override
  void initState() {
    super.initState();
    personnelList = [
      {
        "Name": "John Doe",
        "Gender": "Male",
        "Civil Status": "Single",
        "Employment Status": "Full-Time",
        "Date Started": "01-15-2022",
        "Department": "IT",
        "Degree": "BS Computer Science",
        "Specialization": "Cybersecurity",
        "PWD": "No",
        "Senior Citizen": "No"
      },
    ];
    filteredAccounts = List.from(personnelList);
  }

  void _filterAccounts(String query) {
    setState(() {
      filteredAccounts = query.isEmpty
          ? List.from(personnelList)
          : personnelList.where((account) =>
              account.values.any((value) => value.toLowerCase().contains(query.toLowerCase()))).toList();
    });
  }

  void _showAddPersonnelDialog() {
    final _formKey = GlobalKey<FormState>();
    List<String> genderOptions = ["Male", "Female", "Other"];
    List<String> civilStatusOptions = ["Single", "Married", "Divorced", "Widowed"];
    List<String> employmentStatusOptions = ["Full-Time", "Part-Time", "Contract"];
    List<String> departmentOptions = ["IT", "CSD", "Math", "Science"];
    List<String> degreeOptions = ["Bachelor", "Masters", "Doctorate"];
    List<String> specializationOptions = ["Cybersecurity", "Data Analyst", "Developer"];
    List<String> pwdOptions = ["Yes", "No"];
    List<String> seniorOptions = ["Yes", "No"];

    Map<String, String> newPersonnel = {
      "Name": "",
      "Gender": genderOptions.first,
      "Civil Status": civilStatusOptions.first,
      "Employment Status": employmentStatusOptions.first,
      "Date Started": "",
      "Department": departmentOptions.first,
      "Degree": degreeOptions.first,
      "Specialization": specializationOptions.first,
      "PWD": pwdOptions.first,
      "Senior Citizen": seniorOptions.first,
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Personnel"),
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
                    onChanged: (value) => newPersonnel["Name"] = value,
                    validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Date Started (MM-DD-YYYY)"),
                    controller: TextEditingController(text: newPersonnel["Date Started"]),
                    onChanged: (value) => newPersonnel["Date Started"] = value,
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
                  ...["Gender", "Civil Status", "Employment Status", "Department", "Degree", "Specialization", "PWD", "Senior Citizen"]
                      .map((field) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(labelText: field),
                              value: newPersonnel[field],
                              items: (field == "Gender"
                                      ? genderOptions
                                      : field == "Civil Status"
                                          ? civilStatusOptions
                                          : field == "Employment Status"
                                              ? employmentStatusOptions
                                              : field == "Department"
                                                  ? departmentOptions
                                                  : field == "Degree"
                                                      ? degreeOptions
                                                      : field == "Specialization"
                                                          ? specializationOptions
                                                          : field == "PWD"
                                                              ? pwdOptions
                                                              : seniorOptions)
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  newPersonnel[field] = value as String;
                                });
                              },
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  personnelList.add(newPersonnel);
                  _filterAccounts(searchController.text);
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  void _deletePersonnel(int index) {
    setState(() {
      personnelList.removeAt(index);
      _filterAccounts(searchController.text); // Reapply search filter
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 350,
              child: CustomSearchBar(
                controller: searchController,
                onChanged: _filterAccounts,
              ),
            ),
            AppCustomButton(
              ontab: _showAddPersonnelDialog,
              backgroundColor: AppColors.primary,
              text: "Add New Personnel",
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Scrollbar( // Add a scrollbar to make it visible on the horizontal scroll
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 36,
                  headingRowColor: WidgetStateProperty.all(AppColors.primary),
                  headingTextStyle: context.textTheme.titleSmall!.copyWith(color: AppColors.textSecondary),
                  columns: [
                    "Name", "Gender", "Civil Status", "Employment Status", "Date Started", "Department", "Degree", "Specialization", "PWD", "Senior Citizen", "Actions"
                  ].map((col) => DataColumn(label: Center(child: Text(col)))).toList(),
                  rows: filteredAccounts.map((personnel) {
                    int index = filteredAccounts.indexOf(personnel);
                    return DataRow(
                      cells: [
                        ...personnel.entries.map((entry) => DataCell(Center(child: Text(entry.value)))).toList(),
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
