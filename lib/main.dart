import 'dart:convert';
import 'dart:io';



import 'package:appnode/view/loginPage.dart';
import 'package:appnode/view/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';


import 'package:appnode/view/Quimica.dart';
import 'package:appnode/view/Tareas.dart';
import 'package:appnode/view/Fisica.dart';
import 'package:appnode/view/VideoControlPage.dart';
import 'package:appnode/view/quizhome.dart';
import 'package:appnode/controllers/notificaciones.dart';


notificaciones notifica = notificaciones();
//Método que escucha las notificaciones en segundo plano
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.toString());
  print(message.data['imagen']);
      String titulo = message.data['titulo'];
      String mensaje = message.data['mensaje'];
      String url = message.data['imagen'];
       
  final String largeIconPath = await _downloadAndSaveFile(
        url, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(
        url, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: titulo,
            htmlFormatContentTitle: true,
            summaryText: mensaje,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(channel.id,
            channel.name, channel.description,
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      '',
      message.data['mensaje'],
      platformChannelSpecifics
);
}
//Método que convierte las url que se reciben por notificacion y las convierte en imagenes
Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

//LocalNotification
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    
Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  //Inicializa firebase y el método para escuchar notificaciones en segundo plano
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(
    MyApp(),
  );
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Preparación COLBACH",
      debugShowCheckedModeBanner: false,
      home: MainPageMate(),
      theme: ThemeData(
        accentColor: Colors.white70
      ),
    );
  }
}

class MainPageMate extends StatefulWidget {
  @override
  _MainPageMateState createState() => _MainPageMateState();
}

class _MainPageMateState extends State<MainPageMate> {
 
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    //Métodos para inicializar local notifications
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //Método para escuchar y recibir notificaciones con la app abierta
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print(message.data['imagen']);
      String titulo = message.data['titulo'];
      String mensaje = message.data['mensaje'];
      String url = message.data['imagen'];
      final String largeIconPath = await _downloadAndSaveFile(
        url, 'largeIcon');
      final String bigPicturePath = await _downloadAndSaveFile(
        url, 'bigPicture');
      final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
            largeIcon: FilePathAndroidBitmap(largeIconPath),
            contentTitle: titulo,
            htmlFormatContentTitle: true,
            summaryText: mensaje,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(channel.id,
            channel.name, channel.description,
            styleInformation: bigPictureStyleInformation);
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
     
      if (message.data != null){
        print(message.data.values);
        flutterLocalNotificationsPlugin.show(
            0,
            titulo,
            mensaje,
            platformChannelSpecifics
          );
      }
    });
    //Token FCM
    notificaciones.getToken();
  }
//Revisa si ya se inició sesión y si no, lo manda a LoginPage
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Encabezado de la app
        title: Text("Preparación COLBACH", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(child: Pagina()),
      drawer: Drawer(
        child: ListView(
          //Menú lateral
        children: [
          new UserAccountsDrawerHeader(
            accountName: Text("Preparación COLBACH"),
            accountEmail: Text("Curso en línea"),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/negro.png"),
              fit: BoxFit.cover)
              
            ),
         ),
           new ListTile(
             title: Text("Matemáticas"),
             onTap: (){
               //notificaciones.peticion();
               
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPageMate()),
                    );
             },
           ),
           new ListTile(
             title: Text("Física"),
             onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Fisi()),
                    );
             },
           ),
           new ListTile(
             title: Text("Química"),
             onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Quimi()),
                    );
             },
           ),
           new ListTile(
             title: Text("Tareas"),
             onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tare()),
                    );
             },
           ),
           new ListTile(
             title: Text("Quiz"),
             onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Quiz()),
                    );
             },
           ),
        ],
      ),
      ),
    );
  }


}
class Pagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material es una hoja de papel conceptual en la que aparece la UI.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Preparacion COLBACH',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
        title: Text("Matematicas"),),
        //Cuerpo de la app, donde están los cuadritos de video
        body:  GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children:<Widget> [
            GestureDetector(
              onTap: (){
                var route = new MaterialPageRoute(builder: (BuildContext context) => VideoControPage());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/video.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Video 1: Descripción", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
            GestureDetector(
              onTap: (){
                var route = new MaterialPageRoute(builder: (BuildContext context) => VideoControPage());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/video.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Video 2: Descripción", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
             GestureDetector(
              onTap: (){
                var route = new MaterialPageRoute(builder: (BuildContext context) => VideoControPage());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/video.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Video 3: Descripción", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
              GestureDetector(
              onTap: (){
                var route = new MaterialPageRoute(builder: (BuildContext context) => VideoControPage());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/video.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Video 4: Descripción", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
          ]
        ),
      ),
    );
  }
}

 