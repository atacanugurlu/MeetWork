import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';

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
String tumblrAccount = "Atacan Ugurlu";
String twitterAccount = "Atacan Ugurlu";
String tiktokAccount = "Atacan Ugurlu";
String youtubeAccount = "Atacan Ugurlu";
String redditAccount = "Atacan Ugurlu";
String linkedinAccount = "Atacan Ugurlu";
String twitchAccount = "Atacan Ugurlu";

class Choice {
  Choice({this.accountName, this.mediaName, this.icon});
  String accountName;

  String mediaName;

  IconData icon;
}

List<Choice> choices = [
  Choice(
      mediaName: 'Facebook',
      icon: FontAwesomeIcons.facebook,
      accountName: facebookAccount),
  Choice(
      mediaName: 'Instagram',
      icon: FontAwesomeIcons.instagram,
      accountName: instagramAccount),
  Choice(
      mediaName: 'Twitter',
      icon: FontAwesomeIcons.twitter,
      accountName: twitterAccount),
  Choice(
      mediaName: 'Tumblr',
      icon: FontAwesomeIcons.tumblr,
      accountName: tumblrAccount),
  Choice(
      mediaName: 'Youtube',
      icon: FontAwesomeIcons.youtube,
      accountName: youtubeAccount),
  Choice(
      mediaName: 'Tiktok',
      icon: FontAwesomeIcons.tiktok,
      accountName: tiktokAccount),
  Choice(
      mediaName: 'Reddit',
      icon: FontAwesomeIcons.reddit,
      accountName: redditAccount),
  Choice(
      mediaName: 'LinkedIn',
      icon: FontAwesomeIcons.linkedin,
      accountName: linkedinAccount),
  Choice(
      mediaName: 'Twitch',
      icon: FontAwesomeIcons.twitch,
      accountName: twitchAccount),
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
      child: ListView(children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: basePurple,
          child: ListTile(
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
        ),
      ]),
    );
  }
}
