import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // Utilizando Firestore - Database firebase
        // Recuperando a coleção chat e seus dados, e escutando caso ocorra alguma alteração na coleção
        stream: Firestore.instance.collection('chat').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Recuperando os dados das coleções
          final documents = snapshot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, i) => Container(
              padding: EdgeInsets.all(10),
              child: Text(documents[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Adicionando dados ao Firestore
          Firestore.instance.collection('chat').add({
            'text': 'Adicionado manualmente'
          });
        },
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