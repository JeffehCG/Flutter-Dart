import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    @required this.orders,
    @required this.cartItems,
  }) : super(key: key);

  final Cart cart;
  final Orders orders;
  final List<CartItem> cartItems;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'COMPRAR',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
      onPressed: widget.cart.totalAmount == 0
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              await widget.orders
                  .addOrder(widget.cartItems, widget.cart.totalAmount);
              widget.cart.clear();

              setState(() {
                _isLoading = false;
              });
            },
    );
  }
}
