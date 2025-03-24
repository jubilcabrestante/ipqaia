import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
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
        "Date Started": "2022-01-15",
        "Department": "IT",
        "Degree": "BSc Computer Science",
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
    final formKey = GlobalKey<FormState>();
    Map<String, String> newPersonnel = {
      "Name": "",
      "Gender": "",
      "Civil Status": "",
      "Employment Status": "",
      "Date Started": "",
      "Department": "",
      "Degree": "",
      "Specialization": "",
      "PWD": "No",
      "Senior Citizen": "No"
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Personnel"),
        content: SizedBox(
          width: 500, // Increased width
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: newPersonnel.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: key),
                      onChanged: (value) => newPersonnel[key] = value,
                      validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                    ),
                  );
                }).toList(),
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
              if (formKey.currentState!.validate()) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            Row(
              children: [
                const Gap(20),
                AppCustomButton(
                  ontab: _showAddPersonnelDialog,
                  backgroundColor: AppColors.primary,
                  text: "Add New Personnel",
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 36,
          headingRowColor: WidgetStateProperty.all(AppColors.primary),
          headingTextStyle: context.textTheme.titleSmall!.copyWith(color: AppColors.textSecondary),
          columns: [
            "Name", "Gender", "Civil Status", "Employment Status", "Date Started", "Department", "Degree", "Specialization", "PWD", "Senior Citizen", "Action"
          ].map((col) => DataColumn(label: Center(child: Text(col)))).toList(),
          rows: filteredAccounts.map((personnel) {
            return DataRow(cells: [
              ...personnel.entries.map((entry) => DataCell(Center(child: Text(entry.value)))),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppCustomButton(
                      ontab: () {},
                      backgroundColor: AppColors.delete,
                      text: "Delete",
                    ),
                  ],
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
