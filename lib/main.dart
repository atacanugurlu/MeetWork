import 'package:flutter/material.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/main_screens/social_media_screen.dart';
import 'package:meetwork/screens/main_screens/opening_screen.dart';
import 'package:meetwork/screens/main_screens/business_screen.dart';
import 'package:meetwork/screens/main_screens/qr_code_screen.dart';
import 'package:meetwork/screens/sub_screens/business_card_screen.dart';
import 'package:meetwork/screens/sub_screens/card_collection_screen.dart';
import 'package:meetwork/screens/sub_screens/media_accounts_screen.dart';
import 'package:meetwork/screens/sub_screens/my_card_screen.dart';
import 'package:meetwork/screens/sub_screens/add_social_media_screen.dart';
import 'package:meetwork/screens/sub_screens/my_media_accounts_screen.dart';
import 'package:meetwork/screens/sub_screens/share_card_screen.dart';
import 'package:meetwork/screens/sub_screens/share_media_screen.dart';

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
          BusinessCardScreen.id: (context) => BusinessCardScreen(),
          CardCollectionScreen.id: (context) => CardCollectionScreen(),
          MediaAccountsScreen.id: (context) => MediaAccountsScreen(),
          MyMediaAccountsScreen.id: (context) => MyMediaAccountsScreen(),
          MyCardScreen.id: (context) => MyCardScreen(),
          AddSocialMediaScreen.id: (context) => AddSocialMediaScreen(),
          ShareMediaScreen.id: (context) => ShareMediaScreen(),
          ShareCardScreen.id: (context) => ShareCardScreen(),
        });
  }
}
