import 'dart:io';

import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  void _handlePickedImage(File image) {
    _authData.image = image;
  }

  _submit() {
    bool isValid = _formKey.currentState.validate();
    // Fechando o teclado
    FocusScope.of(context).unfocus();

    // Validando foto tirada
    if (_authData.image == null && _authData.isSignup) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Precisamos da sua foto!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      return;
    }

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup) UserImagePicker(_handlePickedImage),
                  if (_authData.isSignup)
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization
                          .words, // Letra maiuscula para cada palavra
                      enableSuggestions: false,
                      key: ValueKey('name'),
                      initialValue: _authData.name,
                      decoration: InputDecoration(labelText: 'Nome'),
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if ((value == null || value.trim().length < 4) &&
                            _authData.isSignup) {
                          return 'Nome deve ter no minimo 4 caracteres!';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Informe um e-mail valido!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Senha'),
                    onChanged: (value) => _authData.password = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Nome deve ter no minimo 7 caracteres!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  TextButton(
                    child: Text(
                      _authData.isLogin
                          ? 'Criar uma nova conta!'
                          : 'Já possui uma conta?',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
