import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real/model/transaction.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function del;
  TransactionList(this.transaction, this.del);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            elevation: 6,
            child: ListTile(
              leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: FittedBox(
                        child: Text('\$${transaction[index].amount}')),
                  )),
              title: Text(
                transaction[index].tittle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text(DateFormat.yMMMd().format(transaction[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => del(transaction[index].id),
              ),
            ));

        /*Card(
          elevation: 20,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                    '\$${transaction[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: EdgeInsets.all(10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction[index].tittle,
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    transaction[index].date.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );*/
      },
      itemCount: transaction.length,
      // children: transaction.map((tx) {
    );
  }
}
