import 'package:flutter/material.dart';

class NewExplore extends StatefulWidget {
  @override
  _NewExploreState createState() => _NewExploreState();
}

class _NewExploreState extends State<NewExplore> {
  Widget get topSection => Container(
        height: 100.0,
        color: Colors.yellow[300],
      );

  Widget get postDescription => Expanded(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Container(
            height: 10,
            color: Colors.green[300],
            margin: EdgeInsets.only(top: 10)),
        Container(
            height: 10,
            color: Colors.green[300],
            margin: EdgeInsets.only(top: 10)),
        Container(
            height: 10,
            color: Colors.green[300],
            margin: EdgeInsets.only(top: 10))
      ]));

  Widget get actionsToolbar => Container(
        width: 100,
        color: Colors.red[300],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
              5,
              (_) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.blue[300],
                    margin: EdgeInsets.only(top: 20),
                  )),
        ),
      );

  Widget get middleSection => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[postDescription, actionsToolbar],
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
