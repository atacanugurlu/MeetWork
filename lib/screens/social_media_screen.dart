import 'package:flutter/material.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';

class SocialMediaScreen extends StatefulWidget {
  static const id = 'social_media_screen';
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideMenu(routeName: SocialMediaScreen.id),
      appBar: AppBar(
        title: Text("Sosyal Medya"),
      ),
      body: Container(
          width: double.maxFinite,
          child: new ListView.builder(
              itemCount: 14, //will be customer list size
              itemBuilder: (BuildContext context, int index) =>
                  buildCard(context, index))),
    );
  }

  buildCard(BuildContext context, int index) {}
}
