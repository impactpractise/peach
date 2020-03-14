import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/home.dart';
import 'package:peach/widgets/header.dart';
import 'package:peach/widgets/loading.dart';
import 'package:peach/widgets/post.dart';

final usersRef = Firestore.instance.collection('users');

class Explore extends StatefulWidget {
  final User currentUser;

  Explore({this.currentUser});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Post> posts;
  @override
  void initState() {
    super.initState();
    getExplorePage();
  }

  getExplorePage() async {
    QuerySnapshot snapshot = await timelineRef
        .document(widget.currentUser.id)
        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
      print(currentUser);
    });
  }

  buildExplorePage() {
    if (posts == null) {
      return circularProgress(context);
    } else if (posts.isEmpty) {
      return Text('No posts');
    } else {
      return PageView(children: posts, scrollDirection: Axis.vertical);
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: RefreshIndicator(
            onRefresh: () => getExplorePage(), child: buildExplorePage()));
  }
}
