import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peach/models/user.dart';
import 'package:peach/widgets/actions_toolbar.dart';
import 'package:peach/widgets/post.dart';
import 'package:peach/widgets/post_description.dart';

import 'home.dart';

class NewExplore extends StatefulWidget {
  final User currentUser;

  NewExplore({this.currentUser});

  @override
  _NewExploreState createState() => _NewExploreState();
}

class _NewExploreState extends State<NewExplore> {
  List<Post> posts;
  List<String> followingList;

  void initState() {
    super.initState();
    getExplorePage();
    getFollowing();
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
      print(posts[0].username);
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(currentUser.id)
        .collection('userFollowing')
        .getDocuments();
    setState(() {
      followingList = snapshot.documents.map((doc) => doc.documentID).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(posts[1].mediaUrl)))),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text('For you',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              PostDescription(
                username: posts[0].username,
                comments: 5,
                description: posts[0].description,
              ),
              ActionsToolbar(
                postOwnerImage: posts[0].mediaUrl,
                //TODO Add postOwner profile image
                numberOfLikes: posts[0].likesCount.length,
              )
            ],
          )
        ],
      ),
    );
  }
}
