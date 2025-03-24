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

  List<Map<String, String>> personnelList = [
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
    {
      "Name": "Jane Smith",
      "Gender": "Female",
      "Civil Status": "Married",
      "Employment Status": "Part-Time",
      "Date Started": "2020-06-10",
      "Department": "HR",
      "Degree": "MBA",
      "Specialization": "Recruitment",
      "PWD": "No",
      "Senior Citizen": "No"
    }
  ];
  
  List<Map<String, String>> filteredAccounts = [];

  @override
  void initState() {
    super.initState();
    filteredAccounts = List.from(personnelList);
  }

  // Search Functionality
  void _filterAccounts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredAccounts = List.from(personnelList);
      } else {
        filteredAccounts = personnelList.where((account) {
          return account.values.any(
            (value) => value.toLowerCase().contains(query.toLowerCase()),
          );
        }).toList();
      }
    });
  }

  // Show Delete Confirmation Dialog
  void _showDeleteConfirmationDialog(Map<String, String> personnel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Personnel"),
        content: Text("Are you sure you want to delete ${personnel["Name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _deletePersonnel(personnel);
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Delete Personnel
  void _deletePersonnel(Map<String, String> personnel) {
    setState(() {
      personnelList.remove(personnel);
      _filterAccounts(searchController.text); // Ensure the list updates
    });
    log("Deleted personnel: ${personnel["Name"]}");
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
                onChanged: _filterAccounts, // Fix applied here
              ),
            ),
            Row(
              children: [
                const Gap(20),
                AppCustomButton(
                  ontab: () {},
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
            "Name",
            "Gender",
            "Civil Status",
            "Employment Status",
            "Date Started",
            "Department",
            "Degree",
            "Specialization",
            "PWD",
            "Senior Citizen",
            "Action"
          ].map((col) => DataColumn(label: Center(child: Text(col)))).toList(),
          rows: filteredAccounts.map((personnel) { // Now using filteredAccounts
            return DataRow(cells: [
              ...personnel.entries.map((entry) => DataCell(Center(child: Text(entry.value)))).toList(),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppCustomButton(
                      ontab: () => _showDeleteConfirmationDialog(personnel),
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
