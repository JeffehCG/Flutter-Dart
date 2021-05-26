import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class ProductCart extends StatelessWidget {
  final CartItem cartItem;
  ProductCart(this.cartItem);
  @override
  Widget build(BuildContext context) {
    //Providers
    final Cart cart = Provider.of<Cart>(context, listen: false);

    // Dismissible - Componente arrastavel para o lado, iremos utilizar para efetuar a exlusão do item
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection
          .endToStart, // Definindo a direção do Dismiss apenas para um lado
      confirmDismiss: (direction) {
        // Confirmação de exclusão
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Tem certeza?"),
            content: Text('Quer remover o item do carrinho?'),
            actions: [
              TextButton(
                child: Text("Não"),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text("Sim"),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => cart.removeItem(cartItem.productId),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${cartItem.price.toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text(
                'Total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
