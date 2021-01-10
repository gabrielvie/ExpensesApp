import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0;

      for (var transaction in recentTransactions) {
        if (DateFormat.yMd().format(transaction.dateTime) ==
            DateFormat.yMd().format(weekDay)) {
          totalAmount += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(
        0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((e) {
            double pctOfTotal = 0;

            if (totalSpending > 0) {
              pctOfTotal = (e['amount'] as double) / totalSpending;
            }

            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(e['day'], e['amount'], pctOfTotal),
            );
          }).toList(),
        ),
      ),
    );
  }
}
