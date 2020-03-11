import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/edit_profile.dart';
import 'package:peach/screens/home.dart';
import 'package:peach/widgets/header.dart';
import 'package:peach/widgets/loading.dart';
import 'package:peach/widgets/post.dart';
import 'package:peach/widgets/post_tile.dart';

class Profile extends StatefulWidget {
  final String profileId;
  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFollowing = false;
  String profileToggleBar = 'grid';
  final String currentUserId = currentUser?.id;
  String user;
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];

  @override
  initState() {
    super.initState();
    getProfilePosts();
  }

  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef
        .document(widget.profileId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    setState(() {
      isLoading = false;
      postCount = snapshot.documents.length;
      posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(count.toString(),
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 15,
                color: Colors.blueGrey.shade200,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: currentUserId)));
  }

  Container buildButton({String text, Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: FlatButton(
        onPressed: function,
        child: Container(
          child: Text(
            text,
            style: TextStyle(
                color: isFollowing ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold),
          ),
          width: double.infinity,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isFollowing
                  ? Colors.white
                  : Theme.of(context).secondaryHeaderColor,
              border: isFollowing
                  ? Colors.grey
                  : Border.all(color: Theme.of(context).secondaryHeaderColor),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  buildProfileButton() {
    // is this my own Profile? Then show edit profile button
    bool isProfileOwner = currentUserId == widget.profileId;
    if (isProfileOwner) {
      return buildButton(text: 'Edit Profile', function: editProfile);
    } else if (isFollowing) {
      return buildButton(text: 'Unfollow', function: handleUnfollowUser);
    } else if (!isFollowing) {
      return buildButton(text: 'Follow', function: handleFollowUser);
    }
  }

  handleUnfollowUser() {}

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    // Make auth user follower of a user
    followersRef
        .document(widget.profileId)
        .collection('userFollowers')
        .document(currentUserId)
        .setData({});
    // Add user on to auth user following collection
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(widget.profileId)
        .setData({});
    // notify user about new follower
    activityFeedRef
        .document(widget.profileId)
        .collection('feedItems')
        .document(currentUserId)
        .setData({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": currentUser.username,
      "userId": currentUserId,
      "userProfileImg": currentUser.photoUrl,
      "timestamp": timestamp
    });
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: usersRef.document(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        User user = User.fromDocument(snapshot.data);
        return Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blueGrey.shade200,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(user.bio),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCountColumn('Posts', postCount),
                buildCountColumn('Followers', 0),
                buildCountColumn('Following', 0),
              ],
            ),
            buildProfileButton()
          ],
        );
      },
    );
  }

  buildProfilePosts() {
    if (isLoading) {
      return circularProgress(context);
    } else if (posts.isEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/images/no_content.svg', height: 260),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'No posts yet..',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 25),
                )),
          ],
        ),
      );
    } else if (profileToggleBar == 'grid') {
      List<GridTile> gridTiles = [];
      posts.forEach((post) {
        gridTiles.add(GridTile(child: PostTile(post)));
      });
      return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: gridTiles,
          ));
    } else if (profileToggleBar == 'list') {
      return Column(
        children: posts,
      );
    }
  }

  setProfileToggleBar(String profileToggleBar) {
    setState(() {
      this.profileToggleBar = profileToggleBar;
    });
  }

  buildProfileToggleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.grid_on),
          color: profileToggleBar == 'grid'
              ? Theme.of(context).primaryColor
              : Colors.blueGrey,
          onPressed: () => setProfileToggleBar('grid'),
        ),
        IconButton(
          icon: Icon(Icons.list),
          color: profileToggleBar == 'list'
              ? Theme.of(context).primaryColor
              : Colors.blueGrey,
          onPressed: () => setProfileToggleBar('list'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: header(
        context,
        titleText: currentUser.username,
        //TODO show profile owners username
        removeBackButton: false,
      ),
      body: ListView(children: <Widget>[
        buildProfileHeader(),
        Divider(),
        buildProfileToggleBar(),
        Divider(height: 0.0),
        buildProfilePosts()
      ]),
    );
  }
}
