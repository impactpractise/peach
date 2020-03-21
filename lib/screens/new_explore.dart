import 'package:flutter/material.dart';
import 'package:peach/widgets/actions_toolbar.dart';
import 'package:peach/widgets/post_description.dart';

class NewExplore extends StatefulWidget {
  @override
  _NewExploreState createState() => _NewExploreState();
}

class _NewExploreState extends State<NewExplore> {
  Widget get topSection => Container(
        height: 100.0,
        color: Colors.yellow[300],
      );

  Widget get middleSection => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[PostDescription(), ActionsToolbar()],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //Top section
          topSection,
          //Middle section
          middleSection
        ],
      ),
    );
  }
}
