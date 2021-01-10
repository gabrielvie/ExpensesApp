import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/transaction_form.dart';
import 'package:expenses_app/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Personal Expenses';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      theme: ThemeData(
        accentColor: Colors.amber,
        primarySwatch: Colors.green,
        fontFamily: 'MesloLGS NF',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
              subtitle1: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: this.title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({@required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = true;

  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (transaction) => transaction.dateTime.isAfter(
            DateTime.now().subtract(Duration(days: 7)),
          ),
        )
        .toList();
  }

  void _addNewTransaction(
    String transactionTitle,
    double transactionAmound,
    DateTime transactionDateTime,
  ) {
    var uuid = Uuid();
    final newTransaction = Transaction(
      uuid: uuid.v4(),
      title: transactionTitle,
      amount: transactionAmound,
      dateTime: transactionDateTime,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String transactionUuid) {
    setState(() {
      _userTransactions
          .removeWhere((transaction) => transaction.uuid == transactionUuid);
    });
  }

  void _showTransactionForm(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: TransactionForm(_addNewTransaction),
          onTap: () {},
        );
      },
    );
  }

  Widget _buildChartContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    double height,
  ) {
    return Container(
      child: Chart(_recentTransactions),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          height,
    );
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionListWdiget,
  ) {
    return <Widget>[
      Row(
        children: <Widget>[
          Text(
            'Show Chart!',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      _showChart
          ? _buildChartContent(mediaQuery, appBar, 0.7)
          : transactionListWdiget
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionListWdiget,
  ) {
    return <Widget>[
      _buildChartContent(mediaQuery, appBar, 0.3),
      transactionListWdiget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscapeOrientation =
        mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget.title),
            trailing: Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _showTransactionForm(context),
                )
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          )
        : AppBar(title: Text(widget.title));

    final transactionListWdiget = Container(
      child: TransactionList(_userTransactions, _deleteTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
    );

    final pageBodyWidget = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscapeOrientation == true)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                transactionListWdiget,
              ),
            if (isLandscapeOrientation == false)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                transactionListWdiget,
              ),
            // _showChart ? transactionsChartWidget : transactionListWdiget
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBodyWidget,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBodyWidget,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showTransactionForm(context),
                  ),
          );
  }
}
