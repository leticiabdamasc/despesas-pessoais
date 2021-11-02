import 'package:despesas/components/chart_bar.dart';
import 'package:despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  late List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTansactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get weekTotalValue {
    return groupedTansactions.fold(0.0, (sum, t) {
      return sum + (t['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTansactions.map((t) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: (t['day'] as String),
                  valor: (t['value'] as double),
                  percentage: weekTotalValue == 0
                      ? 0
                      : (t['value'] as double) / weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
