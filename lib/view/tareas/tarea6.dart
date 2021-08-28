import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/*void main() {
  runApp(MaterialApp(
    title: 'Syncfusion PDF Viewer Demo',
    home: HomePage(),
  ));
}*/

/// Represents Homepage for Navigation
class Tarea6 extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<Tarea6> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Encabezado de la pantalla
        title: const Text('Tarea 6: Multiplicación de fracciones'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      //Cuerpo de la pantalla, el que contiene al pdf
      body: SfPdfViewer.asset(
        'assets/Tarea6.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}