import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildChartCard('Status of Employment (Main)', Colors.red),
            _buildChartCard('Number of Students per Cluster', Colors.cyan),
            _buildChartCard('Board Passing Rate', Colors.grey),
            _buildChartCard('Status of Employment (Advanced Degrees)', Colors.deepOrange),
            _buildLineGraphCard(),
            _buildBarChartCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Color color) {
    if (title == 'Number of Students per Cluster') {
      return _buildClusterChartCard(title);
    } else if (title == 'Status of Employment (Main)') {
      return _buildEmploymentStatusCard(title);
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClusterChartCard(String title) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(color: Colors.blue, value: 25, title: '25%'),
                          PieChartSectionData(color: Colors.green, value: 15, title: '15%'),
                          PieChartSectionData(color: Colors.orange, value: 20, title: '20%'),
                          PieChartSectionData(color: Colors.purple, value: 10, title: '10%'),
                          PieChartSectionData(color: Colors.red, value: 18, title: '18%'),
                          PieChartSectionData(color: Colors.cyan, value: 12, title: '12%'),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: const [
                      Legend(color: Colors.blue, label: 'Cluster A'),
                      Legend(color: Colors.green, label: 'Cluster B'),
                      Legend(color: Colors.orange, label: 'Cluster C'),
                      Legend(color: Colors.purple, label: 'Cluster D'),
                      Legend(color: Colors.red, label: 'Cluster E'),
                      Legend(color: Colors.cyan, label: 'Cluster F'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmploymentStatusCard(String title) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(color: Colors.blue, value: 30, title: '30%'),
                          PieChartSectionData(color: Colors.green, value: 40, title: '40%'),
                          PieChartSectionData(color: Colors.orange, value: 20, title: '20%'),
                          PieChartSectionData(color: Colors.red, value: 10, title: '10%'),
                        ],
                        sectionsSpace: 2,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    children: const [
                      Legend(color: Colors.blue, label: 'Temporary'),
                      Legend(color: Colors.green, label: 'Permanent'),
                      Legend(color: Colors.orange, label: 'COS'),
                      Legend(color: Colors.red, label: 'Part-timer'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineGraphCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text('Line graph', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('2019');
                            case 1:
                              return const Text('2020');
                            case 2:
                              return const Text('2021');
                            case 3:
                              return const Text('2022');
                            case 4:
                              return const Text('2023');
                          }
                          return const Text('');
                        },
                        reservedSize: 28,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(1, 4),
                        FlSpot(2, 6),
                        FlSpot(3, 5),
                        FlSpot(4, 7),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChartCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text('Accreditation and COPC Compliance', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 85, color: Colors.green)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 92, color: Colors.green)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 78, color: Colors.green)]),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Program A');
                            case 1:
                              return const Text('Program B');
                            case 2:
                              return const Text('Program C');
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final Color color;
  final String label;

  const Legend({required this.color, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
