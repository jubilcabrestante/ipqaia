import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
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
  // Sample list of accounts
  List<Map<String, String>> accounts = [
    {
      'Name': 'John Doe',
      'Email': 'john.doe@example.com',
      'Role': 'Admin',
      'Gender': 'Male',
      'Age': '30',
    },
    {
      'Name': 'Jane Smith',
      'Email': 'jane.smith@example.com',
      'Role': 'User',
      'Gender': 'Female',
      'Age': '25',
    },
    {
      'Name': 'Sam Brown',
      'Email': 'sam.brown@example.com',
      'Role': 'Manager',
      'Gender': 'Male',
      'Age': '35',
    },
  ];

  // Function to handle reset password action
  void _resetPassword(String email) {
    // Show confirmation dialog before resetting the password
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Password Reset'),
        content: Text('Are you sure you want to reset the password for $email?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform the reset password logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Password reset for $email')),
              );
              Navigator.pop(context); // Close the dialog after action
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  // Function to handle delete action
  void _deleteAccount(int index) {
    // Show confirmation dialog before deleting the account
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this account?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                accounts.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deleted')),
              );
              Navigator.pop(context); // Close the dialog after action
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Accounts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 60,
            columns: [
              DataColumn(
                label: Center(
                  child: Container(
                    width: 150, // Adjust the width for the Name column
                    child: const Text('Name'),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Container(
                    width: 250, // Adjust the width for the Email column
                    child: const Text('Email'),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Container(
                    width: 100, // Adjust the width for the Role column
                    child: const Text('Role'),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Container(
                    width: 100, // Adjust the width for the Gender column
                    child: const Text('Gender'),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Container(
                    width: 80, // Adjust the width for the Age column
                    child: const Text('Age'),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Container(
                    width: 60, // Adjust the width for the Actions column
                    child: const Text('Actions'),
                  ),
                ),
              ),
            ],
            rows: List.generate(
              accounts.length,
              (index) {
                final account = accounts[index];
                return DataRow(cells: [
                  DataCell(Center(child: Container(width: 150, child: Text(account['Name']!)))),
                  DataCell(Center(child: Container(width: 250, child: Text(account['Email']!)))),
                  DataCell(Center(child: Container(width: 100, child: Text(account['Role']!)))),
                  DataCell(Center(child: Container(width: 100, child: Text(account['Gender']!)))),
                  DataCell(Center(child: Container(width: 80, child: Text(account['Age']!)))),
                  DataCell(
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.lock_reset, color: Colors.blue),
                            iconSize: 30,  // Adjust the size of the reset icon
                            onPressed: () => _resetPassword(account['Email']!),
                          ),
                          const SizedBox(width: 2), // Adjust the spacing between icons
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            iconSize: 30,  // Adjust the size of the delete icon
                            onPressed: () => _deleteAccount(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
