import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransactionHandler;

  TransactionCard(this.transaction, this.deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$' + transaction.amount.toStringAsFixed(2)),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.dateTime),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransactionHandler(transaction.uuid),
        ),
      ),
    );
  }
}
