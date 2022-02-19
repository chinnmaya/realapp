import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addnewtransaction;
  NewTransaction(this.addnewtransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //const NewTransaction({ Key? key }) : super(key: key);
  final titleConttroller = TextEditingController();

  final amountController = TextEditingController();
  var _selectedDate;

  void submitdata() {
    final enteredtitle = titleConttroller.text;
    final enteredamount = double.parse(amountController.text);
    DateTime timee = _selectedDate;
    if (enteredtitle.isEmpty || enteredamount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addnewtransaction(
      enteredtitle,
      enteredamount,
      timee,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Tittle"),
              controller: titleConttroller,
              onSubmitted: (_) => submitdata(),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: "amount"),
              controller: amountController,
              onSubmitted: (_) => submitdata(),
            ),
            Container(
              height: 90,
              child: Row(
                children: [
                  // ignore: unnecessary_null_comparison
                  Text(_selectedDate == null
                      ? "No date choosen"
                      : 'Picked date:${DateFormat.yMd().format(_selectedDate)}'),

                  FlatButton(
                    child: Text(
                      "Choose date",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _datePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitdata,
              //child: Text("Add Transcation"),
              // textColor: Colors.purple,
              color: Colors.purple,

              child: Text("Add Transcation"),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
