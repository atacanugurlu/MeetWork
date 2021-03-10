import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';

class BusinessScreen extends StatelessWidget {
  static const id = 'business_screen';

  @override
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

class Choice {
  const Choice({this.title, this.icon});

  final String title;

  final IconData icon;
}

const List<Choice> choices = const [
  const Choice(title: 'Business Card', icon: FontAwesomeIcons.idCard),
  const Choice(title: 'Share Card', icon: Icons.share),
  const Choice(title: 'Card Collection', icon: Icons.collections_bookmark),
  const Choice(title: 'LinkedIn', icon: FontAwesomeIcons.linkedin),
  const Choice(title: 'Blabla', icon: Icons.business),
  const Choice(title: 'Preferences', icon: Icons.settings),
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
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Icon(choice.icon, size: 70.0, color: Colors.white)),
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
        ));
  }
}
