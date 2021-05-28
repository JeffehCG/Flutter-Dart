import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          accentColorBrightness: Brightness.dark),
      // - Efetuando controle de acesso com a biblioteca do firebaseAuth
      // Quando é efetuado authenticação na tela AuthScreen, pelo firebase,
      // É guardado os dados retornados da autenticação
      // Dessa forma, com o FirebaseAuth.instance.onAuthStateChanged caso ocorra qualquer mudança
      // Sera chamado o componente de novo, e caso os dados do usuario ja estejam armazenados,
      // Sera redirecionado para tela de chat
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot){
          if(userSnapshot.hasData){
            return ChatScreen();
          }else{
            return AuthScreen();
          }
        } ,
      ),
    );
  }
}
