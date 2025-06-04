import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final List<Map<String, dynamic>> clusters = [
    {
      'cluster': '1',
      'campuses': [
        {'name': 'MAIN CAMPUS', 'students': 800},
        {'name': 'ARACELI', 'students': 150},
        {'name': 'DUMARAN', 'students': 550},
        {'name': 'ROXAS', 'students': 100},
        {'name': 'SAN VICENTE', 'students': 200},
      ],
    },
    {
      'cluster': '2',
      'campuses': [
        {'name': 'CORON', 'students': 360},
        {'name': 'EL-NIDO', 'students': 451},
        {'name': 'LINAPACAN', 'students': 580},
        {'name': 'TAYTAY', 'students': 362},
      ],
    },
    {
      'cluster': '3',
      'campuses': [
        {'name': 'NARRA', 'students': 458},
        {'name': 'QUEZON', 'students': 582},
        {'name': 'RIZAL', 'students': 124},
      ],
    },
    {
      'cluster': '4',
      'campuses': [
        {'name': 'BALABAC', 'students': 63},
        {'name': 'BATARAZA', 'students': 150},
        {'name': 'BROOKE\'S POINT', 'students': 238},
        {'name': 'SOFRONIO ESPAÑOLA', 'students': 145},
      ],
    },
    {
      'cluster': '5',
      'campuses': [
        {'name': 'PCAT', 'students': 324},
        {'name': 'SAN RAFAEL', 'students': 189},
      ],
    },
  ];

  String selectedYear = '2024';
  String selectedSemester = '1st Semester';

  final List<String> yearOptions = ['2022', '2023', '2024', '2025'];
  final List<String> semesterOptions = ['1st Semester', '2nd Semester'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students by Campus')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedYear,
                    decoration: const InputDecoration(labelText: 'Year'),
                    items: yearOptions
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedYear = value;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSemester,
                    decoration: const InputDecoration(labelText: 'Semester'),
                    items: semesterOptions
                        .map((semester) => DropdownMenuItem(
                              value: semester,
                              child: Text(semester),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSemester = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildHeaderRow(),
                for (var cluster in clusters) ...[
                  _buildClusterRow(cluster['cluster']),
                  for (var campus in cluster['campuses'])
                    _buildCampusRow(campus),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: const [
          Expanded(
              child: Text('CLUSTER',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
              child: Text('CAMPUS',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          Expanded(
              child: Text('NUMBER OF STUDENTS',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildClusterRow(String cluster) {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
              child: Text(cluster,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20))),
          const Expanded(child: SizedBox()),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildCampusRow(Map<String, dynamic> campus) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
              child: Text(campus['name'],
                  style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text('${campus['students']}')),
        ],
      ),
    );
  }
}
