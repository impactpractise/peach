import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peach/widgets/header.dart';
import 'package:peach/widgets/loading.dart';

final usersRef = Firestore.instance.collection('users');

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: StreamBuilder<QuerySnapshot>(
            stream: usersRef.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularLoading(context);
              }
              final List<Text> children = snapshot.data.documents
                  .map((doc) => Text(doc['username']))
                  .toList();
              return Container(
                  child: ListView(
                children: children,
              ));
            }));
  }
}
