import 'package:flutter/material.dart';
import 'package:logicdrag/splash_page.dart';

void main() => runApp(new LogicDrag());

class LogicDrag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogicDrag',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new SplashPage(),
    );
  }
}

