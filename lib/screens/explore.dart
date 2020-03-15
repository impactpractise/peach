import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/home.dart';
import 'package:peach/screens/search.dart';
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
  List<String> followingList;
  @override
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

  buildExplorePage() {
    if (posts == null) {
      return circularProgress(context);
    } else if (posts.isEmpty) {
      return buildUsersToFollow();
    } else {
      return ListView(children: posts);
    }
  }

  buildUsersToFollow() {
    return StreamBuilder(
        stream: usersRef
            .orderBy('timestamp', descending: true)
            .limit(30)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress(context);
          }
          List<UserResult> userResults = [];
          snapshot.data.documents.forEach((doc) {
            User user = User.fromDocument(doc);
            final bool isAuthUser = currentUser.id == user.id;
            final bool isFollowingUser = followingList.contains(user.id);
            // remove user's already followed from recommendations

            // remove current user from recommended list
            if (isAuthUser) {
              return;
            } else if (isFollowingUser) {
              return;
            } else {
              UserResult userResult = UserResult(user);
              userResults.add(userResult);
            }
          });

          return Container(
            color: Theme.of(context).accentColor.withOpacity(0.2),
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person_add,
                        color: Theme.of(context).primaryColor, size: 30),
                    SizedBox(width: 8),
                    Text('Inspiring people to follow',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25))
                  ],
                ),
              ),
              Column(children: userResults)
            ]),
          );
        });
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: RefreshIndicator(
            onRefresh: () => getExplorePage(), child: buildExplorePage()));
  }
}
