import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText}) {
  return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        isAppTitle ? 'Peach' : titleText,
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontFamily: isAppTitle ? "Signatra" : "",
            fontSize: isAppTitle ? 50.0 : 22),
      ));
}
