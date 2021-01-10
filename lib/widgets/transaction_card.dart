import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  TransactionItem({
    Key key,
    this.transaction,
    this.deleteTransactionHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransactionHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    final List availableColors = [
      Colors.black,
      Colors.teal,
      Colors.red,
      Colors.blue,
    ];

    _bgColor = availableColors[Random().nextInt(availableColors.length)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$' + widget.transaction.amount.toStringAsFixed(2)),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.dateTime),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () =>
              widget.deleteTransactionHandler(widget.transaction.uuid),
        ),
      ),
    );
  }
}
