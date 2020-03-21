import 'package:flutter/material.dart';

class PostDescription extends StatelessWidget {
  String username;
  String description;
  int comments;

  PostDescription({this.username, this.description, this.comments});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 70,
      padding: EdgeInsets.only(left: 16),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(description),
            Text('See $comments more comments here',
                style: TextStyle(color: Theme.of(context).secondaryHeaderColor))
          ]),
    ));
  }
}
