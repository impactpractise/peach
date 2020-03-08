import 'dart:async';

import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/comments.dart';
import 'package:peach/screens/home.dart';
import 'package:peach/widgets/custom_image.dart';
import 'package:peach/widgets/loading.dart';

class Post extends StatefulWidget {
  final String currentUserId = currentUser?.id;
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  final dynamic likesCount;

  Post(
      {this.postId,
      this.ownerId,
      this.username,
      this.location,
      this.description,
      this.mediaUrl,
      this.likesCount});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
        postId: doc['postId'],
        ownerId: doc['ownerId'],
        username: doc['username'],
        location: doc['location'],
        description: doc['description'],
        mediaUrl: doc['mediaUrl'],
        likesCount: doc['likes']);
  }

  int getLikesCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count++;
      }
    });
    return count;
  }

  @override
  _PostState createState() => _PostState(
      postId: this.postId,
      ownerId: this.ownerId,
      username: this.username,
      location: this.location,
      description: this.description,
      mediaUrl: this.mediaUrl,
      likes: this.likesCount,
      likesCount: getLikesCount(this.likesCount));
}

class _PostState extends State<Post> {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  int likesCount;
  Map likes;
  bool isLiked;
  bool showHeart = false;

  _PostState(
      {this.postId,
      this.ownerId,
      this.username,
      this.location,
      this.description,
      this.mediaUrl,
      this.likes,
      this.likesCount});

  buildPostHeader() {
    return FutureBuilder(
      future: usersRef.document(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        User user = User.fromDocument(snapshot.data);
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            backgroundColor: Colors.blueGrey,
          ),
          title: GestureDetector(
            onTap: () => print('showing profile'),
            child: Text(
              user.username,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text(location),
          trailing: IconButton(
              onPressed: () => print('deleting post..'),
              icon: Icon(
                Icons.more_vert,
              )),
        );
      },
    );
  }

  handleLike() {
    bool _isLiked = likes['currentUserId'] == true;
    if (_isLiked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.${currentUser.id}': false});
      setState(() {
        likesCount--;
        isLiked = false;
        likes['currentUserId'] = false;
      });
    } else if (!_isLiked) {
      postsRef
          .document(ownerId)
          .collection('userPosts')
          .document(postId)
          .updateData({'likes.${currentUser.id}': true});
      setState(() {
        likesCount++;
        isLiked = true;
        likes['currentUserId'] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  buildPostImage() {
    return GestureDetector(
      onDoubleTap: handleLike,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          cachedNetworkImage(mediaUrl),
          showHeart
              ? Animator(
                  duration: Duration(milliseconds: 300),
                  tween: Tween(begin: 0.8, end: 1.5),
                  curve: Curves.bounceInOut,
                  cycles: 0,
                  builder: (anim) => Transform.scale(
                      scale: anim.value,
                      child: Icon(
                        Icons.favorite,
                        size: 80,
                        color: Theme.of(context).primaryColor,
                      )),
                )
              : Text('')
        ],
      ),
    );
  }

  buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
            ),
            GestureDetector(
                onTap: handleLike,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                )),
            Padding(padding: EdgeInsets.only(right: 20)),
            GestureDetector(
                onTap: () => showComments(context,
                    postId: postId, ownerId: ownerId, mediaUrl: mediaUrl),
                child: Icon(Icons.chat,
                    size: 28, color: Theme.of(context).secondaryHeaderColor))
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                '$likesCount likes',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 5),
              child: Text(
                '$username',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(description),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes['currentUserId'] == true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter()
      ],
    );
  }
}

showComments(BuildContext context,
    {String postId, String ownerId, String mediaUrl}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
        postId: postId, postOwnerId: ownerId, postMediaUrl: mediaUrl);
  }));
}
