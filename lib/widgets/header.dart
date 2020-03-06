import 'package:flutter/material.dart';

AppBar header(
  context, {
  bool isAppTitle = false,
  String titleText,
  removeBackButton = false,
}) {
  return AppBar(
      automaticallyImplyLeading: removeBackButton ? false : true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        isAppTitle ? 'Peach' : titleText,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: isAppTitle ? "Signatra" : "",
            fontSize: isAppTitle ? 50.0 : 22),
      ));
}

//const List<IconChoice> iconChoices = const <IconChoice>[
//  const IconChoice(icon: Icons.arrow_back),
//  const IconChoice(icon: Icons.settings_applications),
//  const IconChoice(icon: Icons.chat_bubble_outline),
//  const IconChoice(icon: Icons.message)
//];
