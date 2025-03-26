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
                  child: const Text('College of Science'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(width: 1, color: Colors.black26),
              columnSpacing: 20,
              headingRowColor:
                  WidgetStateColor.resolveWith((states) => Colors.orange),
              columns: [
                DataColumn(
                    label: Text("Department Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("Date Started",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("Bachelor's Degree",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("Master's Degree",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("Doctorate",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("LGBTQ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("Senior Citizen",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("Male/Female",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("Number of Personnel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
                DataColumn(
                    label: Text("PWD",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                  DataCell(Text("")),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
