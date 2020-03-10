import 'package:flutter/material.dart';
import 'package:peach/screens/home.dart';
import 'package:peach/widgets/header.dart';
import 'package:peach/widgets/loading.dart';
import 'package:peach/widgets/post.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;

  PostScreen({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postsRef
            .document(userId)
            .collection('userPosts')
            .document(postId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress(context);
          }
          Post post = Post.fromDocument(snapshot.data);
          return Center(
              child: Scaffold(
            appBar: header(context, titleText: post.description),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                )
              ],
            ),
          ));
        });
  }
}
