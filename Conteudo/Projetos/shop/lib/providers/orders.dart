import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/constants.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({this.id, this.total, this.products, this.date});
}

class Orders with ChangeNotifier {
  String _token;
  String _userId;
  List<Order> _orders = [];

  Orders(this._token, this._userId, this._orders);
  List<Order> get orders {
    return [..._orders];
  }

  int get ordersCount {
    return _orders.length;
  }

  Future<void> loadOrders() async {
    List<Order> loadItems = [];
    // Requisição HTTP
    final response = await get("${AppConstants.BASE_API_URL}orders/$_userId.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    if (data != null) {
      data.forEach((orderId, orderData) {
        loadItems.add(Order(
          id: orderId,
          total: orderData['total'],
          date: DateTime.parse(orderData['date']),
          products: (orderData['products'] as List<dynamic>).map((product) {
            return CartItem(
              id: product['id'],
              price: product['price'],
              productId: product['productId'],
              quantity: product['quantity'],
              title: product['title'],
            );
          }).toList(),
        ));
      });

      _orders = loadItems.reversed.toList();
      notifyListeners();

      return Future.value();
    }
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    final date = DateTime.now();
    // Http
    final url = "${AppConstants.BASE_API_URL}orders/$_userId.json?auth=$_token";
    final response = await post(
      url,
      body: json.encode({
        'total': total,
        'date': date.toIso8601String(),
        'products': products
            .map((cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'title': cartItem.title,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price
                })
            .toList()
      }),
    );

    _orders.insert(
        0,
        Order(
            id: json.decode(response.body)['name'],
            total: total,
            date: date,
            products: products));

    notifyListeners();
  }
}
