const admin = require("firebase-admin");


function initFirebase() {
    const serviceAccount = require('archivo-FCM.json');
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
    });
}

initFirebase();
//Función que envía la información a FCM y llega como notificación a un solo usuario a través del token de FCM
async function sendPushToOneUser(notification) {
//Carga de información que se va a enviar a FCM para que llegue como notificacion
    const message = {
        token: notification.tokenId,
        data: {
            titulo: notification.titulo,
            mensaje: notification.mensaje,
            imagen: notification.imagen
        }
        
    }
    //console.log('hola',message);
    
    await sendMessage(message);
    await sleep(1000)
   
    
}

//Funcion que envía notificaciones por tema, consultar documentación de firebase
function sendPushToTopic(notification) {
    const message = {
        topic: notification.topic,
        data: {
            titulo: notification.titulo,
            mensaje: notification.mensaje
        }
    }
    sendMessage(message);
}

module.exports = { sendPushToOneUser, sendPushToTopic }
//Funcion que se encarga de hacer el envío directamanete por FCM
function sendMessage(message) {
    admin.messaging().send(message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            console.log('Error sending message:', error);
        })
}
function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
  }