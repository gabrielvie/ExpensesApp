import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.purple,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Text(
              '\$' + transaction.amount.toStringAsFixed(2),
              style: TextStyle(
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat().format(transaction.dateTime),
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
