import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.records});

  final List records;

  getStats() {
    var foodSum = 0.0;
    var leisureSum = 0.0;
    var travelSum = 0.0;
    var workSum = 0.0;
    records.forEach((record) {
      if (record['category'] == "Category.food") {
        foodSum += double.parse(record['amount']);
      } else if (record['category'] == "Category.leisure") {
        leisureSum += double.parse(record['amount']);
      } else if (record['category'] == "Category.travel") {
        travelSum += double.parse(record['amount']);
      } else if (record['category'] == "category.work") {
        workSum += double.parse(record['amount']);
      }
    });

    List stats = [foodSum, travelSum, leisureSum, workSum];
    print(stats);
    return stats;
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final record in records) {
      maxTotalExpense += double.parse(record['amount']);
    }
    print(maxTotalExpense);
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    var stats = getStats();
    const icons = [
      Icons.lunch_dining,
      Icons.flight_takeoff,
      Icons.movie,
      Icons.work
    ];

    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final i in stats) // alternative to map()
                  ChartBar(
                    fill: i == 0 ? 0 : i / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: icons
                .map(
                  (icon) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        icon,
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
