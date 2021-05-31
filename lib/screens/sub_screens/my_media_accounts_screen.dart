import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meetwork/screens/sub_screens/media_accounts_screen.dart';

class MyMediaAccountsScreen extends StatefulWidget {
  static const id = 'my_media_accounts_screen';

  @override
  _MyMediaAccountsScreenState createState() => _MyMediaAccountsScreenState();
}

class _MyMediaAccountsScreenState extends State<MyMediaAccountsScreen> {
  String facebookAccount;
  String instagramAccount;
  String tumblrAccount;
  String twitterAccount;
  String tiktokAccount;
  String youtubeAccount;
  String redditAccount;
  String linkedinAccount;
  String twitchAccount;
  List<Choice> choices;

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

    choices = [
      Choice(
          mediaName: 'Facebook Account',
          icon: FontAwesomeIcons.facebook,
          accountName: facebookAccount),
      Choice(
          mediaName: 'Instagram Account',
          icon: FontAwesomeIcons.instagram,
          accountName: instagramAccount),
      Choice(
          mediaName: 'Twitter Account',
          icon: FontAwesomeIcons.twitter,
          accountName: twitterAccount),
      Choice(
          mediaName: 'Tumblr Account',
          icon: FontAwesomeIcons.tumblr,
          accountName: tumblrAccount),
      Choice(
          mediaName: 'Youtube Account',
          icon: FontAwesomeIcons.youtube,
          accountName: youtubeAccount),
      Choice(
          mediaName: 'Tiktok Account',
          icon: FontAwesomeIcons.tiktok,
          accountName: tiktokAccount),
      Choice(
          mediaName: 'Reddit Account',
          icon: FontAwesomeIcons.reddit,
          accountName: redditAccount),
      Choice(
          mediaName: 'LinkedIn Account',
          icon: FontAwesomeIcons.linkedin,
          accountName: linkedinAccount),
      Choice(
          mediaName: 'Twitch Account',
          icon: FontAwesomeIcons.twitch,
          accountName: twitchAccount),
    ];
    return "Accomplished";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readPref(),
        builder: (context, snapshot) {
          if (!(facebookAccount == null &&
              instagramAccount == null &&
              tumblrAccount == null &&
              twitterAccount == null &&
              tiktokAccount == null &&
              youtubeAccount == null &&
              redditAccount == null &&
              linkedinAccount == null &&
              twitchAccount == null)) {
            return Scaffold(
                backgroundColor: sideMenuColor2,
                drawer: BuildSideMenu(routeName: MyMediaAccountsScreen.id),
                appBar: AppBar(
                  title: Text("Social Media Accounts"),
                ),
                body: ListView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(2),
                    itemCount: choices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: ChoiceCard(choice: choices[index]),
                      );
                    }));
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

class Choice {
  Choice({this.accountName, this.mediaName, this.icon});
  String accountName;

  String mediaName;

  IconData icon;
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: double.maxFinite,
      color: sideMenuColor2,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: basePurple,
        child: ListTile(
          dense: true,
          leading: Icon(
            choice.icon,
            size: 35,
            color: sideMenuColor2,
          ),
          subtitle: RichText(
            text: TextSpan(
                text: choice.accountName ?? "Not Available",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          title: RichText(
            text: TextSpan(
                text: choice.mediaName,
                style: TextStyle(
                    color: sideMenuColor2, fontWeight: FontWeight.w800)),
          ),
        ),
      ),
    );
  }
}
