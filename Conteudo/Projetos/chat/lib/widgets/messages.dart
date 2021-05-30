import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Recuperando dados do usuario logado
    final User user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      // Utilizando Firestore - Database firebase
      // Recuperando a coleção chat e seus dados, e escutando caso ocorra alguma alteração na coleção
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // Recuperando os dados das coleções firestore
        final chatDocs = chatSnapshot.data.documents;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, i) => MessageBubble(
            chatDocs[i].get('text'),
            chatDocs[i].get('userName'),
            chatDocs[i].get('userImage'),
            // Identificando se a mensagem é do usuario logado
            chatDocs[i].get('userId') == user.uid,
            key: ValueKey(chatDocs[i].documentID),
          ),
        );
      },
    );
  }
}
