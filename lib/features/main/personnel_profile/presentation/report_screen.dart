import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';

@RoutePage()
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.orange.shade400),
        columns: [
          DataColumn(
              label: Text('Date Started',
                  style: TextStyle(color: AppColors.textSecondary))),
          DataColumn(
              label: Text('Department',
                  style: TextStyle(color: AppColors.textSecondary))),
          DataColumn(
              label: Text('Degree',
                  style: TextStyle(color: AppColors.textSecondary))),
          DataColumn(
              label: Text('Specialization',
                  style: TextStyle(color: AppColors.textSecondary))),
          DataColumn(
              label: Text('PWD',
                  style: TextStyle(color: AppColors.textSecondary))),
          DataColumn(
              label: Text('Senior Citizen',
                  style: TextStyle(color: AppColors.textSecondary))),
          DataColumn(
              label: Text('Action',
                  style: TextStyle(color: AppColors.textSecondary))),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('June 20, 2024')),
            DataCell(Text('CSD')),
            DataCell(Text('Masters')),
            DataCell(Text('Data Analyst')),
            DataCell(Text('Yes')),
            DataCell(Text('No')),
            DataCell(
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Delete',
                    style: TextStyle(color: AppColors.textSecondary)),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
