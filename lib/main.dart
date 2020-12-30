import 'package:flutter/material.dart';

import 'package:expenses_app/widgets/user_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Flutter App';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: this.title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            child: Card(
              color: Colors.blueGrey,
              child: Text('CHART!'),
              elevation: 5,
            ),
          ),
          UserTransactions()
        ],
      ),
    );
  }
}
