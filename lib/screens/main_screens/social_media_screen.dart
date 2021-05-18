import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/sub_screens/media_accounts_screen.dart';
import 'package:meetwork/screens/sub_screens/add_social_media_screen.dart';
import 'package:meetwork/screens/sub_screens/my_media_accounts_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  static const id = 'social_media_screen';

  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sideMenuColor2,
      drawer: BuildSideMenu(routeName: SocialMediaScreen.id),
      appBar: AppBar(
        title: Text("Social Media"),
      ),
      body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(8),
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          crossAxisCount: 2,
          children: List.generate(choices.length, (index) {
            return Center(
              child: ChoiceCard(choice: choices[index]),
            );
          })),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.page});

  final String title;

  final IconData icon;

  final String page;
}

const List<Choice> choices = const [
  const Choice(
      title: 'Set Accounts',
      icon: FontAwesomeIcons.book,
      page: MediaAccountsScreen.id),
  const Choice(
      title: 'My Accounts',
      icon: Icons.account_box_sharp,
      page: MyMediaAccountsScreen.id),
  const Choice(
      title: 'Add Friend',
      icon: FontAwesomeIcons.userFriends,
      page: AddSocialMediaScreen.id),
  const Choice(
      title: 'Preferences', icon: Icons.settings, page: MediaAccountsScreen.id),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: basePurple,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, choice.page);
          },
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child:
                          Icon(choice.icon, size: 70.0, color: sideMenuColor2)),
                  Text(
                    choice.title,
                    style: TextStyle(
                        color: sideMenuColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ]),
          ),
        ));
  }
}
