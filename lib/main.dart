import 'package:flutter/material.dart';
import 'package:flutterapp/home/wrapper.dart';
import 'package:flutterapp/home/home.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: Home(),
    );
  }
}




