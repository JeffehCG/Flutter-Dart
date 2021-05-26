import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function(String) onDelete;
  final Function(BuildContext, Transaction) onUpdate;

  TransactionList(this.transaction, this.onDelete, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, contraints) {
            return Column(
              //Caso a lista esteja vazia
              children: [
                SizedBox(height: contraints.maxHeight * 0.05),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: contraints.maxHeight * 0.05),
                Container(
                  height: contraints.maxHeight * 0.6, // Responsividade
                  child: Image.asset(
                    //Imagem deve estar configurada em pubspec.yaml
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        // : ListView(
        //     children: transaction.map((tr) {
        //       return TransactionItem(
        //         key: ValueKey(tr.id),
        //         tr: tr,
        //         onDelete: onDelete,
        //         onUpdate: onUpdate,
        //       );
        //     }).toList(),
        //   );
        : ListView.builder(
            //Componente de lista - com .builder é possivel deixar a lista paginada
            itemCount: transaction.length, //Qt de itens da lista
            itemBuilder: (ctx, index) {
              // Paginando a lista(Itens seram carregados de acordo com o scroll)
              final tr = transaction[index];
              return TransactionItem(
                key: GlobalObjectKey(tr.id),
                tr: tr,
                onDelete: onDelete,
                onUpdate: onUpdate,
              );
            },
          );
  }
}
