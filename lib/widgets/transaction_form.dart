import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
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
              FlatButton(
                child: Text('Add Transaction'),
                textColor: Theme.of(context).primaryColor,
                onPressed: _submitData,
              )
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
