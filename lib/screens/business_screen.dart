import 'package:flutter/material.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';

class BusinessScreen extends StatefulWidget {
  static const id = 'business_screen';
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideMenu(routeName: BusinessScreen.id),
      appBar: AppBar(
        title: Text("Kartvizit"),
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
