import 'dart:isolate';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class notificaciones{
  static CollectionReference users = FirebaseFirestore.instance.collection('pushtokens');
//Crea un usertoken a partir del token FCM
  static getUsrToken()  async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    String user = await _firebaseMessaging.getToken().then((deviceToken)async{
        String usr ="user${deviceToken?.substring(0,9)}";
        print('Token $deviceToken');
        return usr;
      });        
      return user;
    }
  //Obtiene el token FCM
  static getToken()  async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    String user = await _firebaseMessaging.getToken().then((deviceToken)async{
        String usr =deviceToken;
        return usr;
      });        
      return user;
    }     
}
