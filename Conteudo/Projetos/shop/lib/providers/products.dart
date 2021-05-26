import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/utils/constants.dart';

// Utilizando Observable
class Products with ChangeNotifier {
  List<Product> _items = [];
  String _token;
  String _userId;

  Products([this._token, this._userId, this._items = const []]);

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();
  int get productsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    // Requisição HTTP
    final response =
        await get("${AppConstants.BASE_API_URL}products.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    final favoriteResponse = await get(
        "${AppConstants.BASE_API_URL}userFavorites/$_userId.json?auth=$_token");
    Map<String, dynamic> favoriteData = json.decode(favoriteResponse.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        bool isFavorite = favoriteData == null ? false : favoriteData[productId] ?? false;
        _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite
        ));
      });

      notifyListeners();
    }
  }

  Future<void> addProduct(Product newProduct) async {
    // Requisição HTTP
    final url = "${AppConstants.BASE_API_URL}products.json?auth=$_token";
    final response = await post(
      url,
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
      }),
    );

    _items.add(Product(
        id: json.decode(response.body)['name'], // Id direto do firebase
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl));
    notifyListeners(); // Notificando todos os listeners que uma alteração ocorreu
  }

  Future<void> addProductAsyncrono(Product newProduct) {
    // Requisição HTTP
    final url = "${AppConstants.BASE_API_URL}products.json?auth=$_token";
    // Retorna um Future / Asyncrono - chama o then para recuperar valor
    return post(
      url,
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
      }),
    ).then((response) {
      _items.add(Product(
          id: json.decode(response.body)['name'], // Id direto do firebase
          title: newProduct.title,
          description: newProduct.description,
          price: newProduct.price,
          imageUrl: newProduct.imageUrl));
      notifyListeners(); // Notificando todos os listeners que uma alteração ocorreu
    }).catchError((error) {
      print(error.toString());
      throw error;
    });
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      // Http
      final url =
          "${AppConstants.BASE_API_URL}products/${product.id}.json?auth=$_token";
      await patch(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      // Http
      final url =
          "${AppConstants.BASE_API_URL}products/${product.id}.json?auth=$_token";
      final response = await delete(url);

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }

  // Usando filtro Global
  // bool _showFavoriteOnlie = false;
  // List<Product> get items {
  //   if (_showFavoriteOnlie) {
  //     return _items.where((prod) => prod.isFavorite).toList();
  //   }
  //   return [
  //     ..._items
  //   ];
  // }

  // void showFavoriteOnly() {
  //   _showFavoriteOnlie = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnlie = false;
  //   notifyListeners();
  // }
}
