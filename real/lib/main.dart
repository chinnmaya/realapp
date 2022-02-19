// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:real/widgets/chart.dart';
import 'package:real/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

import 'model/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(id: "t1", tittle: "shoe", amount: 500, date: DateTime.now()),
    Transaction(id: "t2", tittle: "boook", amount: 200, date: DateTime.now()),
  ];
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addnewtransaction(String title, double amount, DateTime timeee) {
    final newtx = Transaction(
        id: DateTime.now().toString(),
        tittle: title,
        amount: amount,
        date: timeee);
    setState(() {
      _userTransaction.add(newtx);
    });
  }

  // const MyHomePage({ Key? key }) : super(key: key);
  void _startnewtx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addnewtransaction));
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  bool _showchart = false;

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text("my app"),
      actions: [
        IconButton(
          onPressed: () => _startnewtx(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("show chart"),
                Switch(
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    }),
              ],
            ),
            _showchart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransaction))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransactionList(_userTransaction, deleteTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startnewtx(context),
      ),
    );
  }
}
