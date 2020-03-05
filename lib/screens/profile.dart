import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peach/models/user.dart';
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

  buildProfileButton() {
    return Text('Profile Button');
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: usersRef.document(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress(context);
        }
        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.blueGrey.shade200,
                    backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.username,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22.0,
                          ),
                        ),
                        Text(
                          user.displayName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Lalalalalla'),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildCountColumn('Posts', 0),
                      buildCountColumn('Followers', 0),
                      buildCountColumn('Following', 0),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[buildProfileButton()],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: header(context,
          titleText: currentUser.username, iconData: Icon(Icons.arrow_back)),
      body: ListView(children: <Widget>[buildProfileHeader()]),
    );
  }
}
