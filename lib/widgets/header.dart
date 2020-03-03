import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle = false, String titleText, removeBackButton = false}) {
  return AppBar(
      automaticallyImplyLeading: removeBackButton ? false : true,
      backgroundColor: Colors.white,
      title: Text(
        isAppTitle ? 'Peach' : titleText,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: isAppTitle ? "Signatra" : "",
            fontSize: isAppTitle ? 50.0 : 22),
      ));
}
