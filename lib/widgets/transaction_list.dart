import 'package:flutter/material.dart';

import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionHandler;

  TransactionList(this.transactions, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              children: <Widget>[
                Text(
                  'There is no transactions',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/crab.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          )
        : ListView(
            children: transactions
                .map((Transaction transaction) => TransactionItem(
                      key: ValueKey(transaction.uuid),
                      transaction: transaction,
                      deleteTransactionHandler: deleteTransactionHandler,
                    ))
                .toList(),
          );
  }
}
