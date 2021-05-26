import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Providers
    final product = Provider.of<Product>(
      context,
      listen:
          false, // Por padrão esse parametro vem como true, caso seja false, não ira mais ouvir as alterações do observer
    );
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    // SnackBar
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          // Animação para quando abrir detalhes do produto, a imagem do produto expande
          // O atributo 'tag' link os dois componentes que iram efetuar a animação
          // Nessa caso sera linkado com o componente ProductDetailScreen 
          child: Hero(
            tag: product.id,
            // Animação para carregar as imagens
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover, // a imagem cobre toda area do componente
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // Utilizando Consumer:
          // Acima definimos o listener de produts como false
          // Pois visualmente a unica coisa que que sofrera alteração é o parametro de favoritos
          // Então dessa forma podemos utilizar o Consumer para ser observado as alterações de produto apenas no trecho de codigo abaixo
          // Ou seja, apenas o widget abaixo sera recarregado ocorrendo alterações
          leading: Consumer<Product>(
            child: Text('Nunca muda'),
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () async {
                try {
                  await product.toogleFavorite(auth.token, auth.userId);
                } catch (error) {
                  scaffoldMessenger.showSnackBar(SnackBar(
                      content: Text(
                    error.toString(),
                  )));
                }
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              // Adicionando produto ao carrinho
              cart.addItem(product);
              ScaffoldMessenger.of(context)
                  .hideCurrentSnackBar(); // Removendo Snackbar caso já esteja aparecendo
              // Exibindo SnackBar para confirmar item no carrinho
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 5),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                  content: Text('Produto adicionado ao carrinho!'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
