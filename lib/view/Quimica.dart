import 'dart:convert';


import 'package:appnode/view/loginPage.dart';
import 'package:appnode/view/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:appnode/view/Fisica.dart';
import 'package:appnode/view/Tareas.dart';
import 'package:appnode/view/VideoControlPage.dart';
import 'package:appnode/view/quizhome.dart';



class Quimi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Preparación COLBACH",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
//Checa si sigue iniciada la sesión, y si no es así, manda a la pantalla de LoginPage
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
        //Encabezado de la aplicación
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
      body: Center(child: Quimica()),
      drawer: Drawer(
        //Menu Lateral
        child: ListView(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
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
class Quimica extends StatelessWidget {
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
        title: Text("Quimica"),),
        //Cuerpo de la aplicación, en donde se encuentran los cuadros para los videos
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