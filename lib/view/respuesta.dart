import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:appnode/controllers/notificaciones.dart';

class Respuesta {
  //Método que envía los temas incorrectos al backend
  Notificaincorrecto(List tema) async{
    print('finale $tema');
    //Obtiene token FCM y genera usrtoken a partir del token
    var token = await notificaciones.getToken();
    var usrToken = await notificaciones.getUsrToken();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //Genera el formato para enviar a backend
    Map data = {
      'usr': usrToken,
      'temas': tema.toString(),
      'token': token
    };
    print(data);
    var jsonResponse = null;
    //Hace la petición http a result
    var response = await http.post(Uri.parse("http://10.0.2.2:3128/result"), body: data);
    print('despues del response');
    //Si se inició correctamente result
    if(response.statusCode == 200) {
      print('200');
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if(jsonResponse != null) {
        print('Correcto');
    }
    else {
      print('Error');
  }
}
  }
}