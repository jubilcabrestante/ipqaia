import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class CopcScreen extends StatefulWidget {
  const CopcScreen({super.key});

  @override
  State<CopcScreen> createState() => _CopcScreenState();
}

class _CopcScreenState extends State<CopcScreen> {
  String selectedCampus = "Select Campus";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List of Accreditation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Button (Aligned Top Right)
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 120,
                height: 40,
                child: AppCustomButton(
                 ontab: () {
                    // Handle add document action
                  },
                  backgroundColor: AppColors.darkGreen,
                  child: const Text(
                    "Add Document",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16), // Space between button and dropdown

            // Dropdown for PSU Campus
            Row(
              children: [
                const Text("PSU CAMPUS: ", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCampus,
                  items: ["Select Campus", "Campus A", "Campus B", "Campus C"]
                      .map((campus) => DropdownMenuItem(
                            value: campus,
                            child: Text(campus),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCampus = value!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Scrollable Data Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border:
                      TableBorder.all(color: Colors.grey), // Add table border
                  columns: const [
                    DataColumn(label: Text("Undergraduate Programs Offered")),
                    DataColumn(label: Text("Year of Initial Operation")),
                    DataColumn(label: Text("COPC Number")),
                    DataColumn(label: Text("Date Issued")),
                    DataColumn(label: Text("Recommendation")),
                    DataColumn(label: Text("Supporting Document")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text("AB in Political Science")),
                      DataCell(Text("1998")),
                      DataCell(Text("3")),
                      DataCell(Text("Jan 1, 2024")),
                      DataCell(Text("AACCUP.docx")),
                      DataCell(Text("PolScie.pdf")),
                      DataCell(Text("Compliant")),
                      DataCell(Text("Delete")),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
