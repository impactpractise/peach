import 'package:flutter/material.dart';

class RoutinePreviewCard extends StatelessWidget {
  final String cardTitle;
  final String numberRoutines;
  final String teaserText;
  final Color colorOne;
  final Color colorTwo;
  const RoutinePreviewCard(
      {this.cardTitle,
      this.numberRoutines,
      this.teaserText,
      this.colorOne,
      this.colorTwo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorOne, colorTwo]),
              borderRadius: BorderRadius.circular(5)),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 12, top: 12),
                child: Text(
                  'NEW',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Center(
                child: Text(
                  cardTitle,
                  style: TextStyle(
                      fontFamily: 'Signatra',
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 50),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          numberRoutines,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        SizedBox(height: 10),
        Text(
          teaserText,
          style: TextStyle(color: Colors.black87, fontSize: 18),
        )
      ],
    );
  }
}
