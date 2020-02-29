import 'package:flutter/material.dart';
import 'package:peach/widgets/header.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true), body: Text('Explore'));
  }
}
