import 'package:flutter/material.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({super.key, required this.transactions});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView(
        children: transactions.map((transaction) {
          return Card(
            margin: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 5,
            ),
            elevation: 7,
            child: Row(
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "R ${transaction.amount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(transaction.date),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
