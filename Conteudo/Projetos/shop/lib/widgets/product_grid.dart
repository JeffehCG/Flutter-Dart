import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    // Recuperando dados do provider
    final productsProvider = Provider.of<Products>(context);
    final List<Product> loadedProducts = showFavoriteOnly
        ? productsProvider.favoriteItems
        : productsProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      // Em baixo esta sendo usado o ChangeNotifierProvider.value em vez do create,
      // por que não esta sendo criado uma nova instancia de ChangeNotifier
      // e sim já utilizando a classe product que ja esta instanciada
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index], // Escutando alterações em produto
        child: ProductGridItem(),
      ),
      itemCount: loadedProducts.length,
      // Quantidade fixa de elementos no eixo CrossAxis (MainAxi - Coluna, CrossAxis - Linha)
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Qt elementos no eixo
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
