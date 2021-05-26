import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';

// Utilizando observer, pra sempre quando ocorrer uma alteração no objeto, os listeners serem avisados
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toogleFavorite(String token, String userId) async {
    isFavorite = !isFavorite;
    notifyListeners(); // Escutar quando o produto for colocado ou tirado de favoritos

    // Http
    final url = "${AppConstants.BASE_API_URL}userFavorites/$userId/${this.id}.json?auth=$token";
    final response = await put(
      url,
      body: json.encode(isFavorite),
    );

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException('Ocorreu um erro ao efetuar a alteração.');
    }
  }
}
