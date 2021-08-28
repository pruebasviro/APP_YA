import 'package:flutter/material.dart';
import '../main.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'package:url_launcher/url_launcher.dart';

const _url = 'https://video1-e3c36.web.app/asignaturas/video.html';
         
class VideoControPage extends StatefulWidget {
  VideoControPage({Key key}) : super(key: key);

  @override
  _VideoControPageState createState() => _VideoControPageState();
}

class _VideoControPageState extends State<VideoControPage> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    //Reproductor de video
    _videoPlayerController = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  //Encabezado de la pantalla del video
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          
          actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Regresar',
            onPressed: () {
              var route = new MaterialPageRoute(builder: (BuildContext context) => Pagina());
              Navigator.of(context).pop(route);
            },
          ),
           ],
          title: Text('Video 1'),
        ),
        
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            //Controles de reproducción
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: Padding(
                      child: Text("Android controls"),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: _launchURL,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("iOS controls"),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

}
void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url,
                      webOnlyWindowName: '_self',) : throw 'Could not launch $_url';
}
