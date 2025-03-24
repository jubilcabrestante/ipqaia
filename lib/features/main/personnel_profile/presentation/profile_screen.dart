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
  void _deletePersonnel(int index) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this personnel?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Close dialog
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              personnelList.removeAt(index);
              _filterAccounts(searchController.text); // Update filtered list
            });
            Navigator.pop(context); // Close dialog
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}


  void _showAddPersonnelDialog() {
    final _formKey = GlobalKey<FormState>();
    
    // Dropdown options
    List<String> genderOptions = ["Male", "Female", "Other"];
    List<String> civilStatusOptions = ["Single", "Married", "Divorced", "Widowed"];
    List<String> employmentStatusOptions = ["Full-Time", "Part-Time", "Contract"];
    List<String> departmentOptions = ["IT", "CSD", "Math", "Science"];
    List<String> degreeOptions = ["Bachelor", "Masters", "Doctorate"];
    List<String> specializationOptions = ["Cybersecurity", "Data Analyst", "Developer"];
    List<String> pwdOptions = ["Yes","No"];
    List<String> seniorOptions = ["Yes","No"];


    Map<String, String> newPersonnel = {
      "Name": "",
      "Gender": "", // Default value
      "Civil Status": "",
      "Employment Status": "",
      "Date Started": "",
      "Department": "",
      "Degree":"",
      "Specialization": "",
      "PWD": "",
      "Senior Citizen": ""
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      onChanged: (value) => newPersonnel["Name"] = value,
                      validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                    ),
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Gender"),
                    value: newPersonnel["Gender"],
                    hint: Text("Select Gender"),
                    items: genderOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["Gender"] = value!;
                    }),
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Civil Status"),
                    value: newPersonnel["Civil Status"],
                    hint: Text("Select Civil Status"),
                    items: civilStatusOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["Civil Status"] = value!;
                    }),
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Employment Status"),
                    value: newPersonnel["Employment Status"],
                    hint: Text("Select Employment Status"),
                    items: employmentStatusOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["Employment Status"] = value!;
                    }),
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Department"),
                    value: newPersonnel["Department"],
                    hint: Text("Select Department"),
                    items: departmentOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["Department"] = value!;
                    }),
                  ),
                   DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Degree"),
                    value: newPersonnel["Degree"],
                    hint: Text("Select degree"),
                    items: degreeOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["Degree"] = value!;
                    }),
                  ),
                   DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Specialization"),
                    value: newPersonnel["Specialization"],
                    hint: Text("Select Specialization"),
                    items: specializationOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["Specialization"] = value!;
                    }),
                  ),
                   DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "PWD"),
                    value: newPersonnel["PWD"],
                    hint: Text("PWD"),
                    items: pwdOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["PWD"] = value!;
                    }),
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Senior Citizen"),
                    value: newPersonnel["Senior Citizen"],
                    items: seniorOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() {
                      newPersonnel["Senior Citizen"] = value!;
                    }),
                  ),
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
              ...personnel.entries.map((entry) => DataCell(Center(child: Text(entry.value)))).toList(),
            DataCell(
              
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      AppCustomButton(
        ontab: () => _deletePersonnel(filteredAccounts.indexOf(personnel)), 
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
