import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/main_screens/business_screen.dart';

class MediaAccountsScreen extends StatefulWidget {
  static const id = 'media_accounts_screen';

  @override
  _MediaAccountsScreenState createState() => _MediaAccountsScreenState();
}

class _MediaAccountsScreenState extends State<MediaAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sideMenuColor2,
        drawer: BuildSideMenu(routeName: MediaAccountsScreen.id),
        appBar: AppBar(
          backgroundColor: sideMenuColor,
          title: Text("Set Accounts"),
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
  }
}

TextEditingController facebookController = TextEditingController();
TextEditingController instagramController = TextEditingController();
TextEditingController tumblrController = TextEditingController();
TextEditingController twitterController = TextEditingController();
TextEditingController tiktokController = TextEditingController();
TextEditingController youtubeController = TextEditingController();
TextEditingController redditController = TextEditingController();
TextEditingController linkedinController = TextEditingController();
TextEditingController twitchController = TextEditingController();

class Choice {
  Choice({this.controllerName, this.mediaName, this.icon});
  TextEditingController controllerName;

  String mediaName;

  IconData icon;
}

List<Choice> choices = [
  Choice(
      mediaName: 'Facebook Account',
      icon: FontAwesomeIcons.facebook,
      controllerName: facebookController),
  Choice(
      mediaName: 'Instagram Account',
      icon: FontAwesomeIcons.instagram,
      controllerName: instagramController),
  Choice(
      mediaName: 'Twitter Account',
      icon: FontAwesomeIcons.twitter,
      controllerName: twitterController),
  Choice(
      mediaName: 'Tumblr Account',
      icon: FontAwesomeIcons.tumblr,
      controllerName: tumblrController),
  Choice(
      mediaName: 'Youtube Account',
      icon: FontAwesomeIcons.youtube,
      controllerName: youtubeController),
  Choice(
      mediaName: 'Tiktok Account',
      icon: FontAwesomeIcons.tiktok,
      controllerName: tiktokController),
  Choice(
      mediaName: 'Reddit Account',
      icon: FontAwesomeIcons.reddit,
      controllerName: redditController),
  Choice(
      mediaName: 'LinkedIn Account',
      icon: FontAwesomeIcons.linkedin,
      controllerName: linkedinController),
  Choice(
      mediaName: 'Twitch Account',
      icon: FontAwesomeIcons.twitch,
      controllerName: twitchController),
];

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
          title: TextFormField(
            controller: choice.controllerName,
            decoration: InputDecoration(
                labelText: choice.mediaName,
                labelStyle: TextStyle(
                  color: sideMenuColor2,
                )),
          ),
          trailing: IconButton(
            icon: Icon(Icons.save),
            color: sideMenuColor2,
            onPressed: () {
              removePref(choice.mediaName);
              savePref(choice.mediaName, choice.controllerName.text);
            },
          ),
        ),
      ),
    );
  }
}
