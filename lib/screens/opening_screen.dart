import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:meetwork/screens/business_screen.dart';
import 'package:meetwork/screens/social_media_screen.dart';
import 'package:meetwork/constants.dart';
import 'dart:async';

class OpeningScreen extends StatefulWidget {
  static const id = 'opening_screen';
  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  Timer _timer;
  bool animated = false;
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 750), (Timer t) {
      setState(() {
        animated = !animated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          color: baseGrey,
          child: SizedBox.expand(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(0.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedDefaultTextStyle(
                        child: Text('Meet'),
                        style: !animated
                            ? TextStyle(
                                color: basePurple,
                                fontSize: 60,
                                fontWeight: FontWeight.normal,
                                letterSpacing: -3)
                            : TextStyle(
                                color: basePurple,
                                fontSize: 60,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -3),
                        duration: Duration(milliseconds: 200),
                      ),
                    ),
                    color: sideMenuColor2,
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, SocialMediaScreen.id);
                      });
                    },
                  ),
                ),
                Expanded(
                    child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 85, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedDefaultTextStyle(
                            child: Text('Work'),
                            style: animated
                                ? TextStyle(
                                    color: sideMenuColor2,
                                    fontSize: 60,
                                    fontWeight: FontWeight.normal,
                                    fontFeatures: [FontFeature.enable('smcp')],
                                    letterSpacing: -3.5,
                                  )
                                : TextStyle(
                                    color: sideMenuColor2,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w900,
                                    fontFeatures: [FontFeature.enable('smcp')],
                                    letterSpacing: -3.5,
                                  ),
                            duration: Duration(milliseconds: 200),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(context, BusinessScreen.id);
                          });
                        }))
              ],
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 50),
            alignment: Alignment.topLeft,
            child: RotatedBox(
              quarterTurns: 1,
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: basePurple,
                          fontSize: 40,
                          fontStyle: FontStyle.italic),
                      text: "Social Media")),
            )),
        Container(
            padding: EdgeInsets.only(bottom: 50),
            alignment: Alignment.bottomRight,
            child: RotatedBox(
              quarterTurns: 3,
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: sideMenuColor2,
                          fontSize: 40,
                          fontStyle: FontStyle.italic),
                      text: "Business")),
            )),
      ]),
    );
  }
}
