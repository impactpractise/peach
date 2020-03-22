import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peach/widgets/routine_preview_card.dart';

class ExploreChallenges extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          'https://images.unsplash.com/photo-1504217051514-96afa06398be?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black45.withOpacity(0.15), BlendMode.darken)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: Text(
                          'Do it for you',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontFamily: 'AvenirLTStd-Roman',
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Guides for your best self',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'AvenirLTStd-Medium',
                              fontSize: 20,
                              letterSpacing: 3),
                        ),
                      ),
                    ),
                    SizedBox(height: 390),
                    Text(
                      'MASTER ROUTINES',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'AvenirLTStd-Medium',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Proven routines, guided by a mentor',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    RoutinePreviewCard(
                        cardTitle: 'Morning Routines',
                        numberRoutines: '200+ Challenges',
                        teaserText:
                            'Have powerful start into your day with people that treat you like family.',
                        colorOne: Theme.of(context).primaryColor,
                        colorTwo: Theme.of(context).accentColor),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    RoutinePreviewCard(
                        cardTitle: 'Meditations',
                        numberRoutines: '100+ Meditations',
                        teaserText:
                            'Make regular meditations a habit and raise the frequency with a powerful community.',
                        colorOne: Colors.lightBlue,
                        colorTwo: Theme.of(context).secondaryHeaderColor),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    RoutinePreviewCard(
                      cardTitle: 'Design',
                      numberRoutines: '150+ Design Experiences',
                      teaserText:
                          'Unleash your inner creative with guidance of a mentor and a supportive community.',
                      colorOne: Colors.cyanAccent,
                      colorTwo: Colors.black45,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
