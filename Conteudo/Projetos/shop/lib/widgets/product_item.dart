import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    // SnackBar
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product, // Passando produto como parametro
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                // Confirmação exclusão
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Tem certeza?"),
                    content: Text('Quer remover o item?'),
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
                          // Provider.of<Products>(context, listen: false)
                          //     .deleteProduct(product.id);
                          Navigator.of(ctx).pop(true);
                        },
                      ),
                    ],
                  ),
                ).then((value) async {
                  // Pode usa o then, ou colocar direto no onPressed
                  if (value) {
                    try {
                      await Provider.of<Products>(context, listen: false)
                          .deleteProduct(product.id);
                    } on HttpException catch (error) {
                      scaffoldMessenger.showSnackBar(SnackBar(
                          content: Text(
                        error.toString(),
                      )));
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
