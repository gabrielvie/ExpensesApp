import 'package:flutter/material.dart';

import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: transactions
              .map((transaction) => TransactionCard(transaction))
              .toList(),
        ),
      ),
    );
  }
}
