import 'package:flutter/material.dart';
import 'package:expense_tracking_app/models/transaction.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  const TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? ElevatedButton.icon(
                          style: ButtonStyle(
                              elevation: const MaterialStatePropertyAll(0),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              foregroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).errorColor)),
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          label: const Text('Delete'))
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
