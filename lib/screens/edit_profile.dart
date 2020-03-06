import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peach/models/user.dart';
import 'package:peach/screens/home.dart';
import 'package:peach/screens/profile.dart';
import 'package:peach/widgets/loading.dart';
import 'package:peach/widgets/textField.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  bool _nameValid = true;
  bool _bioValid = true;
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
    instagramController.text = user.instagram;
    tiktokController.text = user.tiktok;
    youtubeController.text = user.youtube;

    setState(() {
      isLoading = false;
    });
  }

  updateProfileData() async {
    setState(() {
      nameController.text.trim().length < 3 || nameController.text.isEmpty
          ? _nameValid = false
          : _nameValid = true;
      bioController.text.trim().length > 140
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_nameValid && _bioValid) {
      usersRef.document(widget.currentUserId).updateData({
        "displayName": nameController.text,
        "bio": bioController.text,
        "instagram": instagramController.text,
        "tiktok": tiktokController.text,
        "youtube": youtubeController.text,
        "website": websiteController.text
      });
      SnackBar snackbar = SnackBar(content: Text("Success, profile updated"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Profile(
                    profileId: currentUser.id,
                  )));
    }
  }

  logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              onPressed: () => Navigator.pop(context, getUser),
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
                            ReuseableTextFormField(
                                controller: nameController,
                                title: 'Name',
                                label: 'Tell the world about you',
                                isValid: _nameValid,
                                errText: 'Entered name is too short.'),
                            ReuseableTextFormField(
                                controller: bioController,
                                title: 'Bio',
                                label: 'Tell the world about you',
                                isValid: _bioValid,
                                errText:
                                    'Please enter a bio shorter than 140 characters.'),
                            ReuseableTextFormField(
                                controller: instagramController,
                                title: 'Instagram',
                                label: '@username'),
                            ReuseableTextFormField(
                                controller: tiktokController,
                                title: 'TikTok',
                                label: 'username'),
                            ReuseableTextFormField(
                                controller: youtubeController,
                                title: 'Youtube',
                                label: '/Channel or URL'),
                            ReuseableTextFormField(
                                controller: websiteController,
                                title: 'Website',
                                label: 'www.peach.com'),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Theme.of(context).secondaryHeaderColor,
                        onPressed: updateProfileData,
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
                          onPressed: logout,
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.black,
                            size: 12,
                          ),
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
