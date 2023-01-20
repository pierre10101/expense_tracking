import 'package:expense_tracking_app/widgets/bar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});
  final List<Transaction> recentTransactions;
  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalSum = 0.0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }
        return {
          'Day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum,
        };
      },
    );
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, currentItem) {
      return sum + currentItem['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTransactionValues.map((transaction) {
          return Bar(
            label: transaction['Day'],
            spendingAmount: transaction['amount'],
            percentageOfTotal:
                totalSpending == 0 ? 0 : transaction['amount'] / totalSpending,
          );
        }).toList(),
      ),
    );
  }
}
