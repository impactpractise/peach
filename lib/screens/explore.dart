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
  void initState() {
    //createUser();
    //updateUser();
    deleteUser();
    super.initState();
  }

  createUser() async {
    await usersRef
        .document("uniqueSampleString")
        .setData({"username": "Niklas", "postsCount": 8, "isAdmin": false});
  }

  updateUser() async {
    final doc = await usersRef.document("uniqueSampleString").get();
    if (doc.exists) {
      doc.reference.updateData({"username": "Niklas Donges"});
    }
  }

  deleteUser() async {
    final DocumentSnapshot doc =
        await usersRef.document("uniqueSampleString").get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }

  Widget build(context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: StreamBuilder<QuerySnapshot>(
            stream: usersRef.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularProgress(context);
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
