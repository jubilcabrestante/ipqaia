import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search article here...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Gap(25),
            Row(
              children: [
                Text(
                  'COLLEGE',
                  style: context.textTheme.bodyLarge!.copyWith(fontSize: 15),
                ),
                Gap(25),
                AppCustomButton(
                  ontab: () {},
                  child: const Text('grabe mo ka bakla'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 100,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => Colors.orange.shade400),
              columns: const [
                DataColumn(
                    label: Text('Department Name',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('Date Started',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('With Bachelors Degree',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('With Masters Degree',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('With Doctorate',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label:
                        Text('LGBTQ', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('Senior Citizen',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('Male/Female',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('Number of Personnel',
                        style: TextStyle(color: Colors.white))),
                DataColumn(
                    label: Text('PWD', style: TextStyle(color: Colors.white))),
                DataColumn(
                    label:
                        Text('Actions', style: TextStyle(color: Colors.white))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(Text('bakla')),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {},
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
