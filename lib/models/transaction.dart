import 'package:flutter/foundation.dart';

class Transaction {
  final String uuid;
  final String title;
  final double amount;
  final DateTime dateTime;

  Transaction({
    @required this.uuid,
    @required this.title,
    @required this.amount,
    @required this.dateTime,
  });
}
