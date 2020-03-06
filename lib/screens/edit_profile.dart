import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/explore.dart';
import 'package:peach/widgets/loading.dart';
import 'package:peach/widgets/textField.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  bool isLoading = false;
  User user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    nameController.text = user.name;
    bioController.text = user.bio;
    instagramController.text = user.instagramName;
    tiktokController.text = user.tiktokName;
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edit Your Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.done,
                size: 30,
                color: Theme.of(context).secondaryHeaderColor,
              ))
        ],
      ),
      body: isLoading
          ? circularProgress(context)
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              CachedNetworkImageProvider(user.photoUrl),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            textField(
                                controller: nameController,
                                title: 'Name',
                                label: 'Tell the world about you'),
                            textField(
                                controller: bioController,
                                title: 'Bio',
                                label: 'Tell the world about you'),
                            textField(
                                controller: instagramController,
                                title: 'Instagram',
                                label: '@username'),
                            textField(
                                controller: tiktokController,
                                title: 'TikTok',
                                label: 'username'),
                            textField(
                                controller: youtubeController,
                                title: 'Youtube',
                                label: '/Channel or URL'),
                            textField(
                                controller: websiteController,
                                title: 'Website',
                                label: 'www.peach.com'),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).secondaryHeaderColor,
                        onPressed: () => print('update profile data'),
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: FlatButton.icon(
                          onPressed: () => print('logout'),
                          icon: Icon(Icons.cancel, color: Colors.black),
                          label: Text('Logout',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
