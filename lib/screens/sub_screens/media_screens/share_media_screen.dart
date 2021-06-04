import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meetwork/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meetwork/screens/sub_screens/media_screens/media_accounts_screen.dart';
import '../../../components/media_info_class.dart';

class ShareMediaScreen extends StatefulWidget {
  static const id = 'share_media_screen';

  @override
  _ShareMediaScreenState createState() => _ShareMediaScreenState();
}

class _ShareMediaScreenState extends State<ShareMediaScreen> {
  String facebookAccount;
  String instagramAccount;
  String tumblrAccount;
  String twitterAccount;
  String tiktokAccount;
  String youtubeAccount;
  String redditAccount;
  String linkedinAccount;
  String twitchAccount;
  var mediaJSON;

  @override
  void initState() {
    super.initState();
    readPref().then((value) {
      if (facebookAccount == null &&
          instagramAccount == null &&
          tumblrAccount == null &&
          twitterAccount == null &&
          tiktokAccount == null &&
          youtubeAccount == null &&
          redditAccount == null &&
          linkedinAccount == null &&
          twitchAccount == null) {
        Navigator.pushNamed(context, MediaAccountsScreen.id);
      }
    });
  }

  Future<String> readPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    facebookAccount = prefs.getString("Facebook Account");
    instagramAccount = prefs.getString("Instagram Account");
    tumblrAccount = prefs.getString("Tumbler Account");
    twitterAccount = prefs.getString("Twitter Account");
    tiktokAccount = prefs.getString("Tiktok Account");
    youtubeAccount = prefs.getString("Youtube Account");
    redditAccount = prefs.getString("Reddit Account");
    linkedinAccount = prefs.getString("LinkedIn Account");
    twitchAccount = prefs.getString("Twitch Account");

    SocialMediaInfo myInfo = new SocialMediaInfo(
        facebookAccount,
        instagramAccount,
        tumblrAccount,
        twitterAccount,
        tiktokAccount,
        youtubeAccount,
        redditAccount,
        linkedinAccount,
        twitchAccount);
    mediaJSON = json.encode(myInfo.toMap());
    return "Done";
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readPref(),
        builder: (context, snapshot) {
          if ((!(facebookAccount == null &&
              instagramAccount == null &&
              tumblrAccount == null &&
              twitterAccount == null &&
              tiktokAccount == null &&
              youtubeAccount == null &&
              redditAccount == null &&
              linkedinAccount == null &&
              twitchAccount == null))) {
            return Scaffold(
              backgroundColor: sideMenuColor2,
              appBar: AppBar(
                title: Text("Share Media Accounts"),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitFadingCircle(
                    size: 80,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? Colors.white : Colors.purple,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Stack(
                    children: <Widget>[
                      Text(
                        'Open NFC\nGet phones together',
                        style: TextStyle(
                          fontSize: 36,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.white,
                        ),
                      ),
                      Text(
                        'Open NFC\nGet phones together',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
                body: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 230,
                    width: double.maxFinite,
                    child: Text("Loading...")));
          }
        });
  }
}
