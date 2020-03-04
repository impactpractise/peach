import 'package:flutter/material.dart';
import 'package:peach/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peach',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFFFF2660),
          accentColor: Color(0xFFFA6900),
          secondaryHeaderColor: Color(0xFF41EAD4)),
      home: Home(),
    );
  }
}
