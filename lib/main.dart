import 'package:flutter/material.dart';
import 'package:expense_tracking_app/widgets/new_transaction.dart';
import 'package:expense_tracking_app/widgets/transaction_list.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:expense_tracking_app/widgets/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          errorColor: Colors.redAccent,
          fontFamily: 'Quicksand',
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          buttonTheme: const ButtonThemeData(buttonColor: Colors.white)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;
  List<Transaction> get _recentTransactions => _transactions
      .where((transaction) => transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  void _addTransaction(String title, double amount, DateTime date) {
    final transaction = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: UniqueKey().toString(),
    );
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _transactionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(
          addTransaction: _addTransaction,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expenses',
          style: TextStyle(color: Colors.white)),
      actions: <Widget>[
        IconButton(
          onPressed: () => _transactionModal(context),
          icon: const Icon(Icons.add),
        )
      ],
    );
    final Widget transactionListWidget = SizedBox(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
          if (!isLandscape)
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(recentTransactions: _recentTransactions),
            ),
          if (!isLandscape) transactionListWidget,
          if (isLandscape)
            _showChart
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(recentTransactions: _recentTransactions),
                  )
                : transactionListWidget,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _transactionModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
