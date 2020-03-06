import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/edit_profile.dart';
import 'package:peach/screens/home.dart';
import 'package:peach/widgets/header.dart';
import 'package:peach/widgets/loading.dart';

class Profile extends StatefulWidget {
  final String profileId;
  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = currentUser?.id;
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
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.bold),
          ),
          width: double.infinity,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).secondaryHeaderColor),
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
    }
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
                buildCountColumn('Posts', 0),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: header(
        context,
        titleText: currentUser.username,
        removeBackButton: false,
      ),
      body: ListView(children: <Widget>[buildProfileHeader()]),
    );
  }
}
