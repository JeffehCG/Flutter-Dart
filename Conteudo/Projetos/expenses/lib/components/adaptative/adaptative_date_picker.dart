import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  AdaptativeDatePicker({this.selectedDate, this.onDateChanged});

  _showDatePicker(BuildContext context) {
    //Exibindo opçao para escolher data
    showDatePicker(
            context: context,
            initialDate: selectedDate == null ? DateTime.now() : selectedDate,
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then(
            // showDatePicker retorna um objeto do tipo Future, então para receber a data selecionada é preciso utilizar o then, que é um metodo assincrono
            (pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime:
                    selectedDate == null ? DateTime.now() : selectedDate,
                minimumDate: DateTime(2019),
                maximumDate: DateTime.now(),
                onDateTimeChanged: onDateChanged),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data Selecionada: ' +
                          DateFormat('dd/MM/y').format(selectedDate)),
                ),
                TextButton(
                  child: Text(
                    'Selecione Data',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _showDatePicker(context),
                )
              ],
            ),
          );
  }
}
