import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  String selectedCampus = 'PSU Main';
  String? selectedCollege;
  String? selectedYear;

  final List<String> campuses = ['PSU Main', 'External Campus'];
  final List<String> colleges = ['College of Sciences', 'College of Engineering'];
  final List<String> years = ['2023-2024', '2024-2025'];

  final List<Map<String, String>> programs = [
    {
      'college': 'College of Sciences',
      'program': 'Bachelor of Sciences in Information Technology',
      'major': 'N/A',
      'students': '—'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Programs")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campus toggle
            Row(
              children: campuses.map((campus) {
                final isSelected = campus == selectedCampus;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCampus = campus;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.deepOrange : Colors.grey.shade300,
                      foregroundColor: isSelected ? Colors.white : Colors.black87,
                    ),
                    child: Text(campus),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Filters
            Row(
              children: [
                const Text("PSU College:"),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedCollege,
                  hint: const Text("Select college"),
                  onChanged: (value) => setState(() => selectedCollege = value),
                  items: colleges.map((college) {
                    return DropdownMenuItem(value: college, child: Text(college));
                  }).toList(),
                ),
                const SizedBox(width: 32),
                const Text("SY:"),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedYear,
                  hint: const Text("Select year and sem"),
                  onChanged: (value) => setState(() => selectedYear = value),
                  items: years.map((year) {
                    return DropdownMenuItem(value: year, child: Text(year));
                  }).toList(),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Add"),
                )
              ],
            ),
            const SizedBox(height: 24),

            // Table headers
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.deepOrangeAccent,
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Center(child: Text("College Name", style: TextStyle(color: Colors.white)))),
                  Expanded(flex: 3, child: Center(child: Text("Program", style: TextStyle(color: Colors.white)))),
                  Expanded(flex: 2, child: Center(child: Text("Major", style: TextStyle(color: Colors.white)))),
                  Expanded(flex: 2, child: Center(child: Text("Number of Student", style: TextStyle(color: Colors.white)))),
                  Expanded(child: Center(child: Text("Action", style: TextStyle(color: Colors.white)))),
                ],
              ),
            ),

            // Data rows
            Expanded(
              child: ListView.builder(
                itemCount: programs.length,
                itemBuilder: (context, index) {
                  final program = programs[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      color: index % 2 == 0 ? Colors.orange.shade50 : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Center(child: Text(program['college'] ?? ''))),
                        Expanded(flex: 3, child: Center(child: Text(program['program'] ?? ''))),
                        Expanded(flex: 2, child: Center(child: Text(program['major'] ?? ''))),
                        Expanded(flex: 2, child: Center(child: Text(program['students'] ?? ''))),
                        Expanded(
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                // delete action
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text("Delete"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
