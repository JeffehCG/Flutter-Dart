import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/order_button.dart';
import 'package:shop/widgets/product_cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Providers
    final Cart cart = Provider.of<Cart>(context);
    final Orders orders = Provider.of<Orders>(context, listen: false);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Text('Total',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(width: 10),
                    Chip(
                      label: Text('R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                .color,
                          )),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ]),
                  OrderButton(cart: cart, orders: orders, cartItems: cartItems)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemsCount,
            itemBuilder: (ctx, i) => ProductCart(cartItems[i]),
          ))
        ],
      ),
    );
  }
}
