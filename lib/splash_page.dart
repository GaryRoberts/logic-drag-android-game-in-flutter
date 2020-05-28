
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logicdrag/home.dart';


class SplashPage extends StatefulWidget {
  @override
  createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final globalKey = new GlobalKey<ScaffoldState>();
//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), _loader);
    return new Scaffold(
      key: globalKey,
      body: _splashContainer(),
    );
  }
//------------------------------------------------------------------------------
  Widget _splashContainer() {
    return GestureDetector(
      onTap: _loader,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(color: Colors.grey[800]),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                    child: new Image(
                  height: 200.0,
                  width: 200.0,
                  image: new AssetImage("assets/images/ic_launcher.png"),
                  fit: BoxFit.fill,
                )),
                new Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "LogicDrag",
                    style: new TextStyle(color: Colors.white, fontSize: 45.0,fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            )));
  }


void _loader() async {

         Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new HomePage()),
          ); 
}

}
