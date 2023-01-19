import 'package:flutter/material.dart';
import 'package:expense_tracking_app/widgets/transaction_list.dart';
import 'package:expense_tracking_app/widgets/new_transaction.dart';
import 'package:expense_tracking_app/models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Groceries',
      amount: 16.53,
      date: DateTime.now(),
    )
  ];

  void _addTransaction(String title, double amount) {
    final transaction = Transaction(
      title: title,
      amount: amount,
      date: DateTime.now(),
      id: UniqueKey().toString(),
    );
    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(
          addTransaction: _addTransaction,
        ),
        TransactionList(
          transactions: _transactions,
        ),
      ],
    );
  }
}
