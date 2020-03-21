import 'package:flutter/material.dart';

class ActionsToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _getSocialAction(title: '123', icon: Icons.favorite_border),
        _getSocialAction(title: '37 Comments', icon: Icons.chat_bubble_outline),
        _getSocialAction(title: 'Share', icon: Icons.share)
      ]),
    );
  }
}

Widget _getSocialAction({String title, IconData icon}) {
  return Container(
      width: 80,
      height: 70,
      child: Column(
        children: <Widget>[
          Icon(icon, size: 35, color: Colors.black54),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(title, style: TextStyle(fontSize: 12)),
          ),
        ],
      ));
}
