import 'package:flutter/material.dart';

import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/transaction_form.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:uuid/uuid.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      uuid: '5027aec8-33bc-48bf-809d-7f6117fcf682',
      title: 'New Shoes',
      amount: 69.99,
      dateTime: DateTime.now(),
    ),
    Transaction(
      uuid: 'f93d587f-d1f9-4591-a727-988f0dc9f05c',
      title: 'Weekly Groceries',
      amount: 16.53,
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TransactionForm(_addNewTransaction),
          TransactionList(_userTransactions),
        ],
      ),
    );
  }

  void _addNewTransaction(String transactionTitle, double transactionAmound) {
    var uuid = Uuid();
    final newTransaction = Transaction(
      uuid: uuid.v4(),
      title: transactionTitle,
      amount: transactionAmound,
      dateTime: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }
}