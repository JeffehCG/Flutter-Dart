import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text('Sair')
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (item) {
                if (item == 'logout') {
                  // Efetuando logout com a biblioteca FirebaseAuth
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          )
        ],
      ),
      // Rederizando Mensagens Firestore
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}


          // // Utilizando Firestore - Database firebase
          // // Recuperando a coleção chat e seus dados, e escutando caso ocorra alguma alteração na coleção
          // Firestore.instance
          //     .collection('chat')
          //     .snapshots()
          //     .listen((querySnapshot) {
          //   // Acessando o valor de um documento especifico(O primeiro)
          //   print(querySnapshot.documents[0]['text']);
          //   // Mapeando o documento
          //   querySnapshot.documents.forEach((element) {
          //     print(element['text']);
          //   });
          // });