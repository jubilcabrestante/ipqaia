import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/search_bar.dart';

@RoutePage()
class ListOfAccountsScreen extends StatefulWidget {
  const ListOfAccountsScreen({super.key});

  @override
  State<ListOfAccountsScreen> createState() => _ListOfAccountsScreenState();
}

class _ListOfAccountsScreenState extends State<ListOfAccountsScreen> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> allAccounts = [
    {"Name": "John Doe", "Email": "john@example.com", "Role": "Admin", "Gender": "Male", "Age": "30"},
    {"Name": "Jane Smith", "Email": "jane@example.com", "Role": "User", "Gender": "Female", "Age": "25"},
    {"Name": "Alice Brown", "Email": "alice@example.com", "Role": "Editor", "Gender": "Female", "Age": "28"},
  ];

  List<Map<String, String>> filteredAccounts = [];

  @override
  void initState() {
    super.initState();
    filteredAccounts = List.from(allAccounts);
  }

  // Search Functionality
  void _filterAccounts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredAccounts = List.from(allAccounts);
      } else {
        filteredAccounts = allAccounts.where((account) {
          return account.values.any(
            (value) => value.toLowerCase().contains(query.toLowerCase()),
          );
        }).toList();
      }
    });
  }

  // Show Reset Password Dialog
  void _showResetPasswordDialog(String email) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reset Password"),
        content: Text("Are you sure you want to reset the password for $email?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              log("Password reset for $email");
              Navigator.pop(context);
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  // Show Delete Account Dialog
  void _showDeleteAccountDialog(Map<String, String> account) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Account"),
        content: Text("Are you sure you want to delete the account of ${account["Name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _deleteAccount(account);
              Navigator.pop(context);
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  // Delete Account
  void _deleteAccount(Map<String, String> account) {
    setState(() {
      allAccounts.remove(account);
      _filterAccounts(searchController.text);
    });
    log("Deleted account of ${account["Name"]}");
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 115,
          headingRowColor: WidgetStateProperty.all(AppColors.primary),
          headingTextStyle: context.textTheme.titleSmall!.copyWith(color: AppColors.textSecondary),
          columns: ["Name", "Email", "Role", "Gender", "Age", "Actions"]
              .map((col) => DataColumn(label: Center(child: Text(col, textAlign: TextAlign.center)))) 
              .toList(),
          rows: filteredAccounts.map((account) {
            return DataRow(cells: [
              ...account.entries.map((entry) => DataCell(Center(child: Text(entry.value)))).toList(),
              DataCell(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppCustomButton(
                      ontab: () => _showResetPasswordDialog(account["Email"]!),
                      backgroundColor: const Color.fromARGB(255, 229, 105, 105),
                      text: "Reset Password",
                    ),
                    AppCustomButton(
                      ontab: () => _showDeleteAccountDialog(account),
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
