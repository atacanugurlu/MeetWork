import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/sub_screens/business_screens/business_card_screen.dart';
import 'package:meetwork/screens/sub_screens/business_screens/card_collection_screen.dart';
import 'package:meetwork/screens/sub_screens/business_screens/manually_add_card_screen.dart';
import 'package:meetwork/screens/sub_screens/business_screens/my_card_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meetwork/screens/main_screens/business_screen.dart';

class BusinessScreen extends StatefulWidget {
  static const id = 'business_screen';

  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideMenu(routeName: BusinessScreen.id),
      appBar: AppBar(
        title: Text("Business"),
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

const _url = 'https://linkedin.com';
void launchURL() async => (await canLaunch(_url))
    ? await launch(_url)
    : throw 'Could not launch $_url';

class Choice {
  const Choice({this.title, this.icon, this.page});

  final String title;

  final IconData icon;

  final String page;
}

const List<Choice> choices = const [
  const Choice(
      title: 'Create Card',
      icon: FontAwesomeIcons.idCard,
      page: BusinessCardScreen.id),
  const Choice(title: 'My Card', icon: Icons.share, page: MyCardScreen.id),
  const Choice(
      title: 'Card Collection',
      icon: Icons.collections_bookmark,
      page: CardCollectionScreen.id),
  const Choice(title: 'LinkedIn', icon: FontAwesomeIcons.linkedin, page: "url"),
  const Choice(
      title: 'Manually Add Card',
      icon: FontAwesomeIcons.userTag,
      page: ManuallyAddCardScreen.id),
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
        color: sideMenuColor2,
        child: InkWell(
          onTap: () {
            if (choice.page == "url") {
              launchURL();
            } else {
              Navigator.pushNamed(context, choice.page);
            }
          },
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child:
                          Icon(choice.icon, size: 70.0, color: Colors.white)),
                  Text(
                    choice.title,
                    style: TextStyle(
                        color: Colors.white,
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

savePref(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

removePref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}
