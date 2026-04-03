import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatefulWidget {
  final Map<String, double> data;

  const ExpensePieChart({super.key, required this.data});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;

  final List<Color> colors = const [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.brown,
    Colors.indigo,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('No expense data yet'),
        ),
      );
    }

    final entries = widget.data.entries.toList();
    final totalExpense = entries.fold<double>(0, (sum, e) => sum + e.value);

    return Column(
      children: [
        SizedBox(
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            response == null ||
                            response.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            response.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  sectionsSpace: 3,
                  centerSpaceRadius: 68,
                  startDegreeOffset: -90,
                  sections: List.generate(entries.length, (index) {
                    final item = entries[index];
                    final isTouched = index == touchedIndex;
                    final percentage = totalExpense == 0
                        ? 0
                        : (item.value / totalExpense) * 100;

                    return PieChartSectionData(
                      color: colors[index % colors.length],
                      value: item.value,
                      title: '${percentage.toStringAsFixed(0)}%',
                      radius: isTouched ? 74 : 62,
                      titleStyle: TextStyle(
                        fontSize: isTouched ? 14 : 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Total Expense',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '৳${totalExpense.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (touchedIndex != -1) ...[
                    const SizedBox(height: 6),
                    Text(
                      entries[touchedIndex].key,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: List.generate(entries.length, (index) {
            final item = entries[index];
            final color = colors[index % colors.length];
            final percentage = totalExpense == 0
                ? 0
                : (item.value / totalExpense) * 100;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: touchedIndex == index
                    ? color.withOpacity(0.10)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: touchedIndex == index
                      ? color.withOpacity(0.45)
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.key,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '৳${item.value.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}