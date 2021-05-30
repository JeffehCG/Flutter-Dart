import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    // Configurando o push notification
    // Existem 3 cenarios
    // App in Foreground - a aplicação esta ativa na tela (Metodo onMessage())
    // App in Background - a aplicação esta ativa, mas esta em segundo plano (Metodo onBackgroundMessage())
    // App Terminated - a aplicação não esta ativa (Metodo onBackgroundMessage())

    // Para utilizar os metdos do segundo e terceiro estado é preciso que o Flutter_Notification_Click
    // esteja configurado no arquivo android\app\src\main\AndroidManifest.xml dentro de activity

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((message) {
      print('onMessage...');
      print(message);
    });
    FirebaseMessaging.onBackgroundMessage((message) {
      print('onBackgroundMessage...');
      print(message);
      return;
    });
    // final fbm = FirebaseMessaging();
    // fbm.configure(
    //   onMessage: (msg) {
    //     print('onMessage...');
    //     print(msg);
    //     return;
    //   },
    //   onResume: (msg) {
    //     print('onResume...');
    //     print(msg);
    //     return;
    //   },
    //   onLaunch: (msg) {
    //     print('onLaunch...');
    //     print(msg);
    //     return;
    //   },
    // );

    // Solicitação para usuario de permissão para push notification (Apanas para iOS)
    // fbm.requestNotificationPermissions();
    final settings = messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

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
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
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