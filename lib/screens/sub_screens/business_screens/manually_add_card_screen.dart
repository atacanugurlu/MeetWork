import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/database.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/components/business_card_class.dart';
import 'package:meetwork/screens/main_screens/business_screen.dart';
import 'package:meetwork/screens/sub_screens/business_screens/card_collection_screen.dart';
import 'package:meetwork/screens/sub_screens/business_screens/manually_add_card_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManuallyAddCardScreen extends StatefulWidget {
  static const id = 'manually_add_card_screen';
  @override
  _ManuallyAddCardScreenState createState() => _ManuallyAddCardScreenState();
}

@override
final TextEditingController nameController = TextEditingController();
final TextEditingController titleController = TextEditingController();
final TextEditingController companyController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController websiteController = TextEditingController();
final TextEditingController linkedinController = TextEditingController();

class _ManuallyAddCardScreenState extends State<ManuallyAddCardScreen> {
  int counter;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  void _addCard(BusinessCardInfo card) async {
    await _databaseHelper.insert(card);
  }

  @override
  void initState() {
    super.initState();
    getCounter();
  }

  Future<String> getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    counter = prefs.getInt('counter') ?? 2;
    return "Done";
  }

  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt('counter') ?? 2) + 1;
      prefs.setInt('counter', counter);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideMenu(routeName: ManuallyAddCardScreen.id),
      appBar: AppBar(
        title: Text("Add Card"),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          height: 230,
          width: double.maxFinite,
          child: Card(
            elevation: 10,
            shadowColor: Colors.orange,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Stack(
                    children: <Widget>[
                      Expanded(
                        flex: 10,
                        child: Stack(
                          children: [
                            personNameJob(),
                            companyName(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 10,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            phone(),
                            SizedBox(
                              height: 5,
                            ),
                            email(),
                            SizedBox(
                              height: 5,
                            ),
                            website(),
                            SizedBox(
                              height: 5,
                            ),
                            linkedin()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: OutlinedButton.icon(
            onPressed: () {
              BusinessCardInfo addCard = new BusinessCardInfo(
                  counter, // from share preferences counter
                  nameController.text,
                  titleController.text,
                  companyController.text,
                  phoneController.text,
                  emailController.text,
                  websiteController.text,
                  linkedinController.text);
              _addCard(addCard);
              _incrementCounter();
              Navigator.pushNamed(context, CardCollectionScreen.id);
            },
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.orange,
                shadowColor: Colors.orange,
                elevation: 15,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 15)))),
            icon: const Icon(
              Icons.save_alt,
              color: Colors.white,
              size: 20,
            ),
            label: RichText(
                text: TextSpan(
                    text: "Save Card",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
          ),
        )
      ]),
    );
  }
}

Widget personNameJob() {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: 140,
      child: Column(children: <Widget>[
        Container(
          width: 140,
          height: 40,
          child: TextField(
            keyboardType: TextInputType.text,
            autofocus: true,
            controller: nameController,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(15, 20, 1, 1),
              border: OutlineInputBorder(),
              labelText: 'Name Surname',
              labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 140,
          height: 40,
          child: TextField(
              controller: titleController,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(15, 20, 1, 1),
                border: OutlineInputBorder(),
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
              )),
        )
      ]),
    ),
  );
}

Widget companyName() {
  return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: 140,
        height: 40,
        child: TextField(
          controller: companyController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(15, 20, 1, 1),
            border: OutlineInputBorder(),
            labelText: 'Company Name',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ));
}

Widget phone() {
  return Row(
    children: [
      Icon(
        FontAwesomeIcons.phone,
        color: Colors.orange,
        size: 20,
      ),
      SizedBox(
        width: 7,
      ),
      Container(
        width: 90,
        height: 30,
        child: TextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 1),
            border: OutlineInputBorder(),
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      )
    ],
  );
}

Widget email() {
  return Row(
    children: [
      Icon(
        Icons.email,
        color: Colors.orange,
        size: 20,
      ),
      SizedBox(
        width: 7,
      ),
      Container(
        width: 90,
        height: 30,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 1),
            border: OutlineInputBorder(),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      )
    ],
  );
}

Widget website() {
  return Row(
    children: [
      Icon(
        Icons.web,
        color: Colors.orange,
        size: 20,
      ),
      SizedBox(
        width: 7,
      ),
      Container(
        width: 90,
        height: 30,
        child: TextField(
          keyboardType: TextInputType.url,
          controller: websiteController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 1),
            border: OutlineInputBorder(),
            labelText: 'Website',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      )
    ],
  );
}

Widget linkedin() {
  return Row(
    children: [
      Icon(
        FontAwesomeIcons.linkedin,
        color: Colors.orange,
        size: 20,
      ),
      SizedBox(
        width: 7,
      ),
      Container(
        width: 90,
        height: 30,
        child: TextField(
          controller: linkedinController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 1),
            border: OutlineInputBorder(),
            labelText: 'LinkedIn ID',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      )
    ],
  );
}
