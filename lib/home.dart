import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:logicdrag/gameplay.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
  static String tag = 'homepage';
}



class _HomePage extends State<HomePage>
    with SingleTickerProviderStateMixin {

AudioPlayer audioPlayer = new AudioPlayer();

 @override
  void initState() {
    super.initState();
      play();
    
  }


  Future<void> play() async {
  await audioPlayer.play("assets/audio/background.mp3");
}

Future<void> pause() async {
  await audioPlayer.pause();
}

Future<void> stop() async {
  await audioPlayer.stop();
 /* setState(() {
    playerState = PlayerState.stopped;
    position = new Duration();
  }); */
}

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;

     final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Image.asset('assets/images/ic_launcher.png'),
      ),
    );


     final logoLabel = FlatButton(
      child: Text(
        'LogicDrag',
        style: TextStyle(color: Colors.white,fontSize: 30,fontStyle: FontStyle.italic),
      ),
      onPressed: () {


      },
    );


    final playButton =  RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
           navigateToPlay(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.green,
        child: Text('Play', style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic)),
        
      );

       final scoreButton =  RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
         
        },
        padding: EdgeInsets.all(12),
        color: Colors.green,
        child: Text('High Scores', style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic)),
        
      );

      final helpButton =  RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
         
        },
        padding: EdgeInsets.all(12),
        color: Colors.green,
        child: Text('Help', style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic)),
        
      );

      final exitButton =  RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
         
        },
        padding: EdgeInsets.all(12),
        color: Colors.green,
        child: Text('Exit', style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic)),
        
      );

return WillPopScope(
      onWillPop: () async {
    MoveToBackground.moveTaskToBack();
         return false;
      },
    child:Scaffold(
      backgroundColor: Colors.white,
      body: 

     Stack(
        children: <Widget>[
           Center(
            child: new Image.asset(
              'assets/images/menu_bg.jpg',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),

      Center( 
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 50.0, right: 50.0),
          children: <Widget>[
            logo,
            logoLabel,
            SizedBox(height: 45.0),
            playButton,
            SizedBox(height: 10.0),
            scoreButton,
            SizedBox(height: 10.0),
            helpButton,
            SizedBox(height: 10.0),
            exitButton,

          ],
        ),
      ),
      ]
     ),
    ));
  }

  Future navigateToPlay(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => GamePlay()));
}


}



void main() {
   runApp(new HomePage());
 
}
