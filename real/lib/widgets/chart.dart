import 'package:flutter/material.dart';
import 'package:real/widgets/chart_bar.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  //const Chart({ Key? key }) : super(ke//y: key);
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalsum += recentTransaction[i].amount;
        }
      }
      print(DateFormat.E().format(weekday));
      print(totalsum);
      return {
        'day': DateFormat.E().format(weekday).substring(0, 2),
        'amount': totalsum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, itemm) {
      var total;
      total = itemm['amount'];
      return sum + total;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        // fit: FlexFit.tight,
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return ChartBar(
                data['day'] as String,
                data['amount'] as double,
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending);
          }).toList(),
        ),
      ),
    );
  }
}
