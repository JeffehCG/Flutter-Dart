import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions{
    return List.generate(7, (index) { // Gerando uma lista com 7 itens

      final weekDay = DateTime.now().subtract( // Pegando o dia, menos o indice, ou seja, vai pegar do dia atual pra traz
        Duration(days: index),
      );

      // Total das transações do dia
      double totalSum = 0.0;
      for(var i = 0; i < recentTransaction.length; i++){
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMoth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if(sameDay && sameMoth && sameYear){
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0], // Pegando a letra do dia (Sexta = S), 
        'value': totalSum
      };
    }).reversed.toList();
  }

  double get _weekTotalValue{
    return groupedTransactions.fold(0.0, (accumulador, item) {
      return accumulador += item['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Espacamento entre os itens
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight, // Todos elementos iram ocupar o mesmo espaço
              // flex: 2, // Caso um elemento for ocupar mais espaço que outro
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: (_weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue), // Porcentagem valor
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}