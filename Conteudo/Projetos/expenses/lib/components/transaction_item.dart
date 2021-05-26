import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {

  // Aqui esta sendo utilizado o parametro key, para identificar Widget instanciado com o seus respectivo state element
  // Essa abordagem é dificilmente utilizado
  // Nesse caso esta sendo necessaria, por que o TransactionItem é um Stateful, e esta sendo utilizado por uma ListView
  // Sem a utililização do parametro key, os componentes acabam se perdendo na hora da exibição da cor ao deletar um item
  // Para referenciar o componente com seu respectivo elemento de estado esta sendo utilizado o id da transação

  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.onDelete,
    @required this.onUpdate,
  }) : super(key: key);

  final Transaction tr;
  final Function(String p1) onDelete;
  final Function(BuildContext p1, Transaction p2) onUpdate;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black
  ];

  Color _backgroundColor;

  @override
    void initState() {
      super.initState();

      int i = Random().nextInt(5);
      _backgroundColor = colors[i]; 
    }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox( //Adapta o texto interno, pra dimnuir de acordo com o componente
              child: Text(
                'R\$${widget.tr.value.toStringAsFixed(2)}'
                )),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date)
        ),
        trailing: Wrap(
          children: MediaQuery.of(context).size.width > 400 // Responsividade - Tratativa de largura
            ? [
                TextButton.icon(
                  icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                  onPressed: () => widget.onDelete(widget.tr.id),
                  label: Text('Excluir', style: TextStyle(color: Theme.of(context).errorColor)),
                ),
                TextButton.icon(
                  icon: Icon(Icons.update,color: Theme.of(context).primaryColor),
                  onPressed: () => widget.onUpdate(context, widget.tr),
                  label: Text('Alterar', style: TextStyle(color: Theme.of(context).primaryColor)),
                )
              ]
            :[
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget.onDelete(widget.tr.id),
                ),
                IconButton(
                  icon: Icon(Icons.update),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => widget.onUpdate(context, widget.tr),
                )
              ]
        ),      
      ),
    );
  }
}
