import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  void submitData() {
    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);
    DateTime enterDate = _selectDate;
    if (enterTitle.isEmpty || enterAmount <= 0) {
      return;
    }
    widget.addTx(
      enterTitle,
      enterAmount,
      enterDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
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
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_selectDate}'),
                  TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Pilih Tanggal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: submitData,
                  child: Text("Proses"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
