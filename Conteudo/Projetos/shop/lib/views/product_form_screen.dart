import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  // Gerenciando foco do formulario
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  // Controller da imagem
  final _imageUrlController = TextEditingController();

  // Controlando o Formulario
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  // Loading
  bool _isLoading = false;

  void _updateImageUrl() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');

    return (startWithHttps || startWithHttp) &&
        (endsWithJpeg || endsWithJpg || endsWithPng);
  }

  Future<void> _saveForm() async {
    // Verificando se o formulario esta valido
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    final newProduct = Product(
        id: _formData['id'],
        title: _formData['title'],
        price: _formData['price'],
        description: _formData['description'],
        imageUrl: _formData['imageUrl']);

    setState(() {
      _isLoading = true;
    });

    // Provider
    // Para utilizar o provider fora da arvore de componentes é preciso deixar o listen - false
    final products = Provider.of<Products>(context, listen: false);
    // Salvando de forma Syncrona
    try {
      if (_formData['id'] == null) {
        await products.addProduct(newProduct);
      } else {
        await products.updateProduct(newProduct);
      }
    } catch (e) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o produto'),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop(); // voltando para pagina anterior
    }
  }

  // Salvar de forma Asyncrona
  Future<void> _addProductAsyncrono(Products products, Product newProduct) {
    return products.addProductAsyncrono(newProduct).catchError((error) {
      return showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o produto'),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop(); // voltando para pagina anterior
    });
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      // Recuperando protudo enviado via rota
      final product = ModalRoute.of(context).settings.arguments as Product;

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = _formData['imageUrl'];
      } else {
        _formData['price'] = 0.0;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                autovalidateMode: AutovalidateMode
                    .onUserInteraction, // Ativando auto validação
                key: _form, // Controlando formulario
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['title'],
                      decoration: InputDecoration(labelText: 'Titulo'),
                      textInputAction:
                          TextInputAction.next, // Ir para o proximo item
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) => _formData['title'] = value,
                      validator: (value) {
                        // Caso seja retornado algo diferente de nullo, sera identificado com um erro
                        if (value.trim().isEmpty) {
                          return 'Informe um titulo valido!';
                        }
                        if (value.trim().length < 4) {
                          return 'Informe um titulo com no minimo 3 letras!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price'].toString(),
                      decoration: InputDecoration(labelText: 'Preço'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) =>
                          _formData['price'] = double.parse(value),
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        var newPrice = double.tryParse(value);
                        bool isInvalid = newPrice == null || newPrice <= 0;

                        if (isEmpty || isInvalid) {
                          return 'Informa um Preço válida!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description'],
                      decoration: InputDecoration(labelText: 'Descrição'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) => _formData['description'] = value,
                      validator: (value) {
                        bool isEmpty = value.trim().isEmpty;
                        bool isInvalid = value.trim().length < 10;

                        if (isEmpty || isInvalid) {
                          return 'Informa uma Descrição válida com no minimo 10 caracteres!';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Alinha no eixo secundario
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'URL da Imagem'),
                            keyboardType: TextInputType.url,
                            focusNode: _imageUrlFocusNode,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            controller: _imageUrlController,
                            onSaved: (value) => _formData['imageUrl'] = value,
                            validator: (value) {
                              bool emptyUrl = value.trim().isEmpty;
                              bool invalidUrl = !isValidImageUrl(value);
                              if (emptyUrl || invalidUrl) {
                                return 'Informa uma URL válida!';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 8, left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text('Informe a URL')
                              : Image.network(_imageUrlController.text),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
