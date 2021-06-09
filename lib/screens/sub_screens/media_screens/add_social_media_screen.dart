import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AddSocialMediaScreen extends StatefulWidget {
  static const id = 'add_social_media_screen';

  @override
  _AddSocialMediaScreenState createState() => _AddSocialMediaScreenState();
}

class _AddSocialMediaScreenState extends State<AddSocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sideMenuColor2,
        drawer: BuildSideMenu(routeName: AddSocialMediaScreen.id),
        appBar: AppBar(
          backgroundColor: sideMenuColor,
          title: Text("Add Friend"),
        ),
        body: ListView.builder(
            primary: false,
            padding: const EdgeInsets.all(2),
            itemCount: choices.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: ChoiceCard(choice: choices[index]),
              );
            }));
  }
}

String facebookAccount = "Atacan Ugurlu";
String instagramAccount = "Atacan Ugurlu";
String tumblrAccount;
String twitterAccount = "Atacan Ugurlu";
String tiktokAccount = "Atacan Ugurlu";
String youtubeAccount = "Atacan Ugurlu";
String redditAccount = "Atacan Ugurlu";
String linkedinAccount = "Atacan Ugurlu";
String twitchAccount = "Atacan Ugurlu";

class Choice {
  Choice({this.accountName, this.mediaName, this.link, this.icon});
  String accountName;

  String mediaName;

  String link;

  IconData icon;
}

List<Choice> choices = [
  Choice(
      mediaName: 'Facebook',
      icon: FontAwesomeIcons.facebook,
      link:
          "https://www.facebook.com/search/people" + (facebookAccount ?? "NAN"),
      accountName: facebookAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'Instagram',
      icon: FontAwesomeIcons.instagram,
      link: 'https://www.instagram.com/' + (instagramAccount ?? "NAN"),
      accountName: instagramAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'Twitter',
      icon: FontAwesomeIcons.twitter,
      link: "https://twitter.com/search/" + (twitterAccount ?? "NAN"),
      accountName: twitterAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'Tumblr',
      icon: FontAwesomeIcons.tumblr,
      link: "https://www.tumblr.com/search/" + (tumblrAccount ?? "NAN"),
      accountName: tumblrAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'Youtube',
      icon: FontAwesomeIcons.youtube,
      link: "https://www.youtube.com/results?search_query=" +
          (youtubeAccount ?? "NAN"),
      accountName: youtubeAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'Tiktok',
      icon: FontAwesomeIcons.tiktok,
      link: "https://www.tiktok.com/search?q=" + (tiktokAccount ?? "NAN"),
      accountName: tiktokAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'Reddit',
      icon: FontAwesomeIcons.reddit,
      link: "https://www.reddit.com/search/?q=" + (redditAccount ?? "NAN"),
      accountName: redditAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'LinkedIn',
      icon: FontAwesomeIcons.linkedin,
      link: "https://www.linkedin.com/search/results/all/?keywords=" +
          (linkedinAccount ?? "NAN") +
          "&origin=GLOBAL_SEARCH_HEADER",
      accountName: linkedinAccount ?? "NOT AVAILABLE"),
  Choice(
      mediaName: 'Twitch',
      icon: FontAwesomeIcons.twitch,
      link: "https://www.twitch.tv/search?term=" + (twitchAccount ?? "NAN"),
      accountName: twitchAccount ?? "NOT AVAILABLE"),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        width: double.maxFinite,
        color: sideMenuColor2,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: basePurple,
          child: ListTile(
            onTap: () {
              if (choice.accountName != "NOT AVAILABLE") {
                launchURL(choice.link);
              } else {
                AlertDialog alert = AlertDialog(
                  content: Text(
                    "User does not have a/an " + choice.mediaName + " account",
                    style: TextStyle(color: sideMenuColor2, fontSize: 24),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Understood",
                          style: TextStyle(color: Colors.purple, fontSize: 18),
                        ))
                  ],
                  elevation: 25,
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            },
            dense: true,
            leading: Icon(
              choice.icon,
              size: 35,
              color: sideMenuColor2,
            ),
            title: RichText(
                text: TextSpan(
                    text: choice.mediaName,
                    style: TextStyle(color: sideMenuColor2))),
            subtitle: RichText(
              text: TextSpan(
                  text: choice.accountName,
                  style: TextStyle(color: Colors.white)),
            ),
            trailing: Icon(
              Icons.add,
              color: sideMenuColor2,
            ),
          ),
        ));
  }
}

void launchURL(mediaName) async => (await canLaunch(mediaName))
    ? await launch(mediaName)
    : throw 'Could not launch $mediaName';
