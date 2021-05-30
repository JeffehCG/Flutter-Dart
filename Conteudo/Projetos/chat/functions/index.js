const functions = require("firebase-functions");
const admin = require('firebase-admin')

admin.initializeApp()

// Monitorando as alterações dentro da coleção chat do firestore
exports.createMsg = functions.firestore
    .document('chat/{msgId}')
    .onCreate((snap, context) => {
        admin
            .messaging()
            .sendToTopic('chat', { // Topic são assuntos de mensagem, exemplo de venda, se alerta etc...
                notification: { // Conteudo da mensagem // Com o registro que foi alterado na coleção
                    title: snap.data().userName,
                    body: snap.data().text
                }
            })
    });

    // // Create and Deploy Your First Cloud Functions
    // // https://firebase.google.com/docs/functions/write-firebase-functions
    //
    // exports.helloWorld = functions.https.onRequest((request, response) => {
    //   functions.logger.info("Hello logs!", {structuredData: true});
    //   response.send("Hello from Firebase!");
    // });