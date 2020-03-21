import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ActionsToolbar extends StatelessWidget {
  String postOwnerImage;
  int numberOfLikes;
  String postOwnerId;
  dynamic showUserProfile;
  ActionsToolbar(
      {this.postOwnerImage,
      this.numberOfLikes,
      this.postOwnerId,
      this.showUserProfile});
  // Full dimensions of an action
  static const double ActionWidgetSize = 60;

  // Size of icon shown for social actions
  static const double ActionIconSize = 35;

  // Size of share social icon
  static const double ShareActionIconSize = 25;

  // Size of profile image in follow action
  static const double ProfileImageSize = 50;

  // Siz of plus icon under profile image in follow action
  static const double AddIconSize = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _getFollowAction(),
        _getSocialAction(
            title: '$numberOfLikes likes', icon: Icons.favorite_border),
        _getSocialAction(title: 'Share', icon: Icons.share)
      ]),
    );
  }

  Widget _getSocialAction({String title, IconData icon}) {
    return Container(
        width: ActionWidgetSize,
        height: ActionWidgetSize,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Icon(icon, size: ActionIconSize, color: Colors.black54),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(title, style: TextStyle(fontSize: 12)),
            ),
          ],
        ));
  }

  Widget _getProfilePicture() {
    return Positioned(
        left: (ActionWidgetSize / 2) - (ProfileImageSize / 2),
        child: Container(
          padding:
              EdgeInsets.all(1.0), // Add 1.0 point padding to create border
          height: ProfileImageSize, // ProfileImageSize = 50.0;
          width: ProfileImageSize, // ProfileImageSize = 50.0;
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ProfileImageSize / 2)),
          // import 'package:cached_network_image/cached_network_image.dart'; at the top to use CachedNetworkImage
          child: GestureDetector(
            onTap: () => showUserProfile,
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(postOwnerImage),
              backgroundColor: Colors.blueGrey,
            ),
          ),
        ));
  }

//  CachedNetworkImage(
//  imageUrl: postOwnerImage,
//  placeholder: (context, url) => circularProgress(context),
//  errorWidget: (context, url, error) => new Icon(Icons.error),
//  )
  Widget _getAddIcon() {
    return Positioned(
      bottom: 0,
      left: ((ActionWidgetSize / 2) - (AddIconSize / 2)),
      child: Container(
          width: AddIconSize, // PlusIconSize = 20.0;
          height: AddIconSize, // PlusIconSize = 20.0;
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 43, 84),
              borderRadius: BorderRadius.circular(15.0)),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 20.0,
          )),
    );
  }

  Widget _getFollowAction() {
    return Container(
      width: ActionWidgetSize,
      height: ActionWidgetSize,
      child: Stack(
        children: <Widget>[_getProfilePicture(), _getAddIcon()],
      ),
    );
  }
}
