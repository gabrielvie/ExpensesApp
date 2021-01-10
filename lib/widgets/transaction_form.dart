import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/widgets/adaptative_flat_button.dart';

class TransactionForm extends StatefulWidget {
  final Function addTransactionHandler;

  TransactionForm(this.addTransactionHandler);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: (MediaQuery.of(context).viewInsets.bottom) + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData,
              ),
              DateTimeField(
                decoration: InputDecoration(labelText: 'Date'),
                controller: dateTimeController,
                format: DateFormat('yyyy-MM-dd'),
                onShowPicker: (context, value) {
                  return showDatePicker(
                    context: context,
                    initialDate: value ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: AdaptativeFlatButton('Add Transaction', _submitData),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final enteredDateTime = DateTime.parse(dateTimeController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        dateTimeController.text.isEmpty) {
      return;
    }

    widget.addTransactionHandler(
      enteredTitle,
      enteredAmount,
      enteredDateTime,
    );

    Navigator.of(context).pop();
  }
}
