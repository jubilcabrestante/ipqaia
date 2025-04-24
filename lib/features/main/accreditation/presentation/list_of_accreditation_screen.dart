import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class ListOfAccreditationScreen extends StatefulWidget {
  const ListOfAccreditationScreen({super.key});

  @override
  State<ListOfAccreditationScreen> createState() =>
      _ListOfAccreditationScreenState();
}

class _ListOfAccreditationScreenState extends State<ListOfAccreditationScreen> {
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
            Align(
              alignment: Alignment.topRight, // Aligns to the top left
              child: SizedBox(
                width: 120, // Adjust width to match the image
                height: 40,  // Adjust height if needed
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


            // Dropdown for PSU Campus
            Row(
              children: [
                const Text("PSU CAMPUS: "),
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

            // Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Undergraduate Programs Offered")),
                  DataColumn(label: Text("Year of Initial Operation")),
                  DataColumn(label: Text("Program Accreditation")),
                  DataColumn(label: Text("Date Started")),
                  DataColumn(label: Text("Recommendation")),
                  DataColumn(label: Text("Supporting Document")),
                  DataColumn(label: Text("Remarks")),
                  DataColumn(label: Text("Action")),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text("AB in Political Science")),
                    DataCell(Text("1998")),
                    DataCell(Text("Level 3")),
                    DataCell(Text("Jan 1, 2024")),
                    DataCell(Text("Recommendation 1")),
                    DataCell(Text("PolScie.pdf")),
                    DataCell(Text("AACCUP Technical Review.docx")),
                    DataCell(Text("Request Deferment")),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
