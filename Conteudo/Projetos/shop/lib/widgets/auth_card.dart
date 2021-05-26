import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth.exception.dart';
import 'package:shop/providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  // Utilizando TickerProvider para  animação (Sincronia da animação com as mudanças de quadro)

  final Map<String, String> _authData = {'email': '', 'password': ''};
  AuthMode _authMode = AuthMode.Login;

  GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  // Trabalhando com animações - Forma manual
  AnimationController _animationController;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  @override
  initState() {
    super.initState();
    _animationController = AnimationController(
      // O widget precisa implementar o provider SingleTickerProviderStateMixin
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      // Tipo de curva (Exemplo, animação começa rapida e termina devagar)
      curve: Curves.linear,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5), // Deslocamento do eixo y, de cima pra baixo
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Ocorreu um erro!"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState.save();

    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await auth.login(_authData['email'], _authData['password']);
      } else {
        await auth.signup(_authData['email'], _authData['password']);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog("Ocorreu um erro inesperado!");
    }

    setState(() {
      _isLoading = false;
    });
  }

  _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      // Fazendo a animação ir do inicio pro final (Ou seja, de 0.0 para 1.0 de altura)
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      // Revertendo animação
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviciSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // Utilizando um componente de animação
      // builder - Recebe o componente que sofrera animação
      // child - Recebera o componente interno que não sofrera animação
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        // Reponsividade - 75% da tela
        width: deviciSize.width * 0.75,
        height: _authMode == AuthMode.Login ? 295 : 375,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return "Informa um e-mail valido!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                controller: _passwordController,
                obscureText: true, // Não aparecer os dados digitados
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return "Informa um senha valida!";
                  }
                  return null;
                },
                onSaved: (value) => _authData['password'] = value,
              ),
              AnimatedContainer(
                // Controlando a exibição do campo de confirmação de senha. escondendo e aparecendo
                constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                // Animação de opacidade
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  // Animação de Slide
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Confirmar Senha'),
                      obscureText: true, // Não aparecer os dados digitados
                      keyboardType: TextInputType.emailAddress,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return "Senhas são diferentes!";
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
              ),
              Spacer(),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
                  child: Text(
                    _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                    style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.button.color),
                  ),
                  onPressed: _submit,
                ),
              TextButton(
                child: Text(
                  "ALTERAR PARA ${_authMode == AuthMode.Login ? 'REGISTRAR' : 'ENTRAR'}",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: _switchAuthMode,
              )
            ],
          ),
        ),
      ),
    );
  }
}


      // Utilizando um componente de animação (Com AnimatedBuilder)

      
      // Trabalhando com animações - Forma manual
      //AnimationController _animationController;
      //Animation<Size> _heightAnimation; // Tipo da animação



      // @override
      // initState() {
      //   super.initState();
      //   _animationController = AnimationController(
      //     // O widget precisa implementar o provider SingleTickerProviderStateMixin
      //     vsync: this,
      //     duration: Duration(milliseconds: 300),
      //   );

      //   _heightAnimation = Tween(
      //     begin: Size(double.infinity, 295),
      //     end: Size(double.infinity, 375),
      //   ).animate(CurvedAnimation(
      //     parent: _animationController,
      //     // Tipo de curva (Exemplo, animação começa rapida e termina devagar)
      //     curve: Curves.linear,
      //   ));

      //   // Escutando alterações nas animações / Forma Manual
      //   // _heightAnimation.addListener(() => setState(() {}));
      // }

      // @override
      // void dispose() {
      //   super.dispose();
      //   _animationController.dispose();
      // }

      // _switchAuthMode() {
      //   if (_authMode == AuthMode.Login) {
      //     setState(() {
      //       _authMode = AuthMode.Signup;
      //     });
      //     // Fazendo a animação ir do inicio pro final (Ou seja, de 295 para 375 de altura)
      //     _animationController.forward();
      //   } else {
      //     setState(() {
      //       _authMode = AuthMode.Login;
      //     });
      //     // Revertendo animação
      //     _animationController.reverse();
      //   }
      // }


      // builder - Recebe o componente que sofrera animação
      // child - Recebera o componente interno que não sofrera animação
      // child: AnimatedBuilder(
      //   animation: _heightAnimation,
      //   child: Form(
      //       key: _formKey,
      //       child: Column(
      //         children: [
      //           TextFormField(
      //             decoration: InputDecoration(labelText: 'E-mail'),
      //             keyboardType: TextInputType.emailAddress,
      //             validator: (value) {
      //               if (value.isEmpty || !value.contains('@')) {
      //                 return "Informa um e-mail valido!";
      //               }
      //               return null;
      //             },
      //             onSaved: (value) => _authData['email'] = value,
      //           ),
      //           TextFormField(
      //             decoration: InputDecoration(labelText: 'Senha'),
      //             controller: _passwordController,
      //             obscureText: true, // Não aparecer os dados digitados
      //             keyboardType: TextInputType.emailAddress,
      //             validator: (value) {
      //               if (value.isEmpty || value.length < 5) {
      //                 return "Informa um senha valida!";
      //               }
      //               return null;
      //             },
      //             onSaved: (value) => _authData['password'] = value,
      //           ),
      //           if (_authMode == AuthMode.Signup)
      //             TextFormField(
      //               decoration: InputDecoration(labelText: 'Confirmar Senha'),
      //               obscureText: true, // Não aparecer os dados digitados
      //               keyboardType: TextInputType.emailAddress,
      //               validator: _authMode == AuthMode.Signup
      //                   ? (value) {
      //                       if (value != _passwordController.text) {
      //                         return "Senhas são diferentes!";
      //                       }
      //                       return null;
      //                     }
      //                   : null,
      //             ),
      //           Spacer(),
      //           if (_isLoading)
      //             CircularProgressIndicator()
      //           else
      //             ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                   primary: Theme.of(context).primaryColor,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(30),
      //                   ),
      //                   padding:
      //                       EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
      //               child: Text(
      //                 _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
      //                 style: TextStyle(
      //                     color:
      //                         Theme.of(context).primaryTextTheme.button.color),
      //               ),
      //               onPressed: _submit,
      //             ),
      //           TextButton(
      //             child: Text(
      //               "ALTERAR PARA ${_authMode == AuthMode.Login ? 'REGISTRAR' : 'ENTRAR'}",
      //               style: TextStyle(color: Theme.of(context).primaryColor),
      //             ),
      //             onPressed: _switchAuthMode,
      //           )
      //         ],
      //       ),
      //     ),
      //   builder: (ctx, child) => Container(
      //     // Reponsividade - 75% da tela
      //     width: deviciSize.width * 0.75,
      //     // height: _authMode == AuthMode.Login ? 295 : 375,
      //     height: _heightAnimation.value.height, // Utilizando animação criada
      //     padding: EdgeInsets.all(16.0),
      //     child: child
      //   ),
      // ),