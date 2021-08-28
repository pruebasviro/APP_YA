import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:appnode/main.dart';
import 'package:appnode/view/loginPage.dart';
import 'package:appnode/view/signupPage.dart';
import 'package:appnode/view/Quimica.dart';
import 'package:appnode/view/Fisica.dart';
import 'package:appnode/view/VideoControlPage.dart';
import 'package:appnode/view/tareas/pdfviewer.dart';
import 'package:appnode/view/tareas/tarea2.dart';
import 'package:appnode/view/tareas/tarea3.dart';
import 'package:appnode/view/tareas/tarea4.dart';
import 'package:appnode/view/tareas/tarea5.dart';
import 'package:appnode/view/tareas/tarea6.dart';
import 'package:appnode/view/tareas/tarea7.dart';
import 'package:appnode/view/tareas/tarea8.dart';
import 'package:appnode/view/tareas/tarea9.dart';
import 'package:appnode/view/tareas/tarea10.dart';
import 'package:appnode/view/quizhome.dart';




class Tare extends StatelessWidget {
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
      body: Center(child: Tareas()),
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
class Tareas extends StatelessWidget {
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
        appBar: AppBar(title: Text("Tareas"),),
        //Cuerpo de la aplicación, donde se encuentran los cuadritos de las tareas
        body:  GridView.count(
          // Crea una grid con 2 columnas. Si cambias el scrollDirection a
          // horizontal, esto produciría 2 filas.
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children:<Widget> [
            GestureDetector(
              onTap: (){
                var route= new MaterialPageRoute(builder: (BuildContext context) => HomePages());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 1: Expresión algebraica.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
            GestureDetector(
              onTap: () {
               var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea2());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 2: Ley de signos de suma y resta.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
             GestureDetector(
              onTap: (){
                var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea3());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 3: Ley de signos de multiplicación y división.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
              GestureDetector(
              onTap: (){
               var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea4());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 4: Suma y resta de fracciones método directo.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
              GestureDetector(
              onTap: (){
                var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea5());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 5: Suma y resta de fracciones.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
            GestureDetector(
              onTap: () {
               var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea6());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 6: Multiplicación de fracciones", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
             GestureDetector(
              onTap: (){
                var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea7());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 7: División de fracciones", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
              GestureDetector(
              onTap: (){
               var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea8());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 8: Ley de exponentes de suma y resta.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
              GestureDetector(
              onTap: (){
               var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea9());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 9: Ley de exponentes de multiplicación.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
              GestureDetector(
              onTap: (){
               var route= new MaterialPageRoute(builder: (BuildContext context) => Tarea10());
                Navigator.of(context).push(route);
              },
              child:Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tarea.jpg"),
                fit: BoxFit.cover)
              
            ),
                child: GridTile(
                   child: Container(),
                   footer: Container(
                    padding: EdgeInsets.all(24),
                    alignment: Alignment.center,
                    color:Colors.black,
                    child:Text("Tarea 10: Ley de exponentes de división.", style:TextStyle(color: Colors.white),),
                    ),
               )
                
              ),),
          ]
          // Genera 100 Widgets que muestran su índice en la lista
          /*List.generate(20, (index) {
            return Center(
            
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }),*/
        ),
      ),
    );
  }
}