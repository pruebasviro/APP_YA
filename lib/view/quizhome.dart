import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:appnode/view/quizpage.dart';
import 'package:appnode/view/loginPage.dart';
import 'package:appnode/view/signupPage.dart';
import 'package:appnode/view/Quimica.dart';
import 'package:appnode/view/Tareas.dart';
import 'package:appnode/view/Fisica.dart';
import 'package:appnode/view/VideoControlPage.dart';
import 'package:appnode/main.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Preparación COLBACH",
      debugShowCheckedModeBanner: false,
      home: MainPageQuiz(),
      theme: ThemeData(
        accentColor: Colors.white70
      ),
    );
  }
}

class MainPageQuiz extends StatefulWidget {
  @override
  _MainPageQuizState createState() => _MainPageQuizState();
}

class _MainPageQuizState extends State<MainPageQuiz> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }
//Para comprobar el estado de la autenticación, si sigue iniciada la sesión. Si no, lo regresa a LoginPage()
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Cabecera de la aplicacion
      appBar: AppBar(
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
      body: Center(child: homepage()),
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
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
//Imagenes de los cuadritos de test disponibles
  List<String> images = [
    "assets/images/py.png",
    "assets/images/java.png",
    "assets/images/js.png",
    "assets/images/cpp.png",
    "assets/images/linux.png",
  ];
//Textos de los cuadritos de test disponibles
  List<String> des = [
    "Test 1 Física/Geometría analítica",
    "Java has always been one of the best choices for Enterprise World. If you think you have learn the Language...\nJust Test Yourself !!",
    "Javascript is one of the most Popular programming language supporting the Web.\nIt has a wide range of Libraries making it Very Powerful !",
    "C++, being a statically typed programming language is very powerful and Fast.\nit's DMA feature makes it more useful. !",
    "Linux is a OPEN SOURCE Operating System which powers many Servers and Workstation.\nIt is also a top Priority in Developement Work !",
  ];

  Widget customcard(String langname, String image, String des){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            // in changelog 1 we will pass the langname name to ther other widget class
            // this name will be used to open a particular JSON file 
            // for a particular language
            builder: (context) => getjson(langname),
          ));
          //Notify1();
          
        },
        child: Material(
          color: Colors.indigoAccent,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      // changing from 200 to 150 as to look better
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    langname,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "Alike"
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz simulacro",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        //Este muestra los cuadritos para ingresar al test con la imagen y su texto correspondiente
        children: <Widget>[
          customcard("Test 1", images[0], des[0]),
          /*customcard("Java", images[1], des[1]),
          customcard("Javascript", images[2], des[2]),
          customcard("C++", images[3], des[3]),
          customcard("Linux", images[4], des[4]),*/
        ],
      ),
    );
  }
}