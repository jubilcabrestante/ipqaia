import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/search_bar.dart';

@RoutePage()
class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> columnTitles = [
      'Department name',
      'Date Started',
      'With Bachelors degree',
      'With Masters degree',
      'With Doctorate',
      'Lgbtq',
      'Senior Citizen',
      'Male/Female',
      'Number of personnel Pwd',
    ];

    final List<List<String>> data = [
      [
        'Department name',
        'Date Started',
        'With Bachelors degree',
        'With Masters degree',
        'With Doctorate',
        'Lgbtq',
        'Senior Citizen',
        'Male/Female',
        'Number of personnel Pwd',
      ],
      [
        'Department name',
        'Date Started',
        'With Bachelors degree',
        'With Masters degree',
        'With Doctorate',
        'Lgbtq',
        'Senior Citizen',
        'Male/Female',
        'Number of personnel Pwd',
      ],
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        title: SizedBox(
          width: 300,
          child: Row(
            children: [
              Expanded(child: CustomSearchBar(controller: searchController)),
            ],
          ),
        ),
        foregroundColor: AppColors.textSecondary,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(AppColors.primary),
          columnSpacing: 20,
          columns: columnTitles
              .map(
                (title) => DataColumn(
                  label: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              )
              .toList(),
          rows: data.map((row) {
            return DataRow(
              cells: row.map((value) => DataCell(Text(value))).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
