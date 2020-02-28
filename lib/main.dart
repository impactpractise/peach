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
      home: Home(),
    );
  }
}
