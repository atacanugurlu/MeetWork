import 'package:flutter/material.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/social_media_screen.dart';
import 'package:meetwork/screens/opening_screen.dart';
import 'package:meetwork/screens/business_screen.dart';
import 'package:meetwork/screens/qr_code_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MeetWork',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: baseGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: OpeningScreen.id,
        routes: {
          OpeningScreen.id: (context) => OpeningScreen(),
          SocialMediaScreen.id: (context) => SocialMediaScreen(),
          BusinessScreen.id: (context) => BusinessScreen(),
          QRCodeScreen.id: (context) => QRCodeScreen(),
        });
  }
}
