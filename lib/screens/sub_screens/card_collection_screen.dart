import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/main_screens/business_screen.dart';
import 'package:meetwork/screens/sub_screens/business_card_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:meetwork/business_card_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardCollectionScreen extends StatefulWidget {
  static const id = 'card_collection_screen';

  @override
  _CardCollectionScreenState createState() => _CardCollectionScreenState();
}

class _CardCollectionScreenState extends State<CardCollectionScreen> {
  String name;
  String title;
  String company;
  String phone;
  String email;
  String website;
  String linkedin;

  @override
  void initState() {
    super.initState();

    readPref().then((value) {
      if (name == null) {
        Navigator.pushNamed(context, BusinessCardScreen.id);
      }
    });
  }

  Future<String> readPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name");
    title = prefs.getString("title");
    company = prefs.getString("company");
    phone = prefs.getString("phone");
    email = prefs.getString("email");
    website = prefs.getString("website");
    linkedin = prefs.getString("linkedin");
    return "Accomplished";
  }

  Widget personNameJobWidget(String name, String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 150,
        child: RichText(
          text: TextSpan(
            text: name,
            style: GoogleFonts.raleway(
                fontStyle: FontStyle.italic, color: Colors.black, fontSize: 23),
            children: <TextSpan>[
              TextSpan(
                  text: "\n" + title,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget companyNameWidget(String company) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: GestureDetector(
        onTap: () {
          location(company);
        },
        child: Container(
          width: 140,
          child: Text(
            company,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: GoogleFonts.lato(
                fontStyle: FontStyle.italic, color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget phoneWidget(String phone) {
    return GestureDetector(
      onTap: () {
        phoneCall(phone);
      },
      child: Row(
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
            child: RichText(
                text: TextSpan(
                    text: phone,
                    style: GoogleFonts.lato(fontSize: 8, color: Colors.black))),
          ),
        ],
      ),
    );
  }

  Widget emailWidget(String email) {
    return GestureDetector(
      onTap: () {
        sendEmail(email);
      },
      child: Row(
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
            child: RichText(
                text: TextSpan(
                    text: email,
                    style: GoogleFonts.lato(fontSize: 8, color: Colors.black))),
          ),
        ],
      ),
    );
  }

  Widget websiteWidget(String website) {
    return GestureDetector(
      onTap: () {
        launchURL();
      },
      child: Row(
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
            child: RichText(
                text: TextSpan(
                    text: website,
                    style: GoogleFonts.lato(fontSize: 8, color: Colors.black))),
          ),
        ],
      ),
    );
  }

  Widget linkedinWidget(String linkedin) {
    return GestureDetector(
      onTap: () {
        launchURL();
      },
      child: Row(
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
            child: RichText(
                text: TextSpan(
                    text: linkedin,
                    style: GoogleFonts.lato(fontSize: 8, color: Colors.black))),
          ),
        ],
      ),
    );
  }

  void phoneCall(String phoneNumber) {
    if (phoneNumber != null && phoneNumber != '') {
      launch('tel:${phoneNumber.replaceAll(' ', '').replaceAll('-', '')}');
    }
  }

  void sendEmail(String emailAddress) {
    if (emailAddress != null && emailAddress != '') {
      launch('mailto:$emailAddress');
    }
  }

  void location(String address) {
    if (address != null && address != '') {
      MapsLauncher.launchQuery(address);
    }
  }

  final _url = 'https://linkedin.com';
  void launchURL() async => (await canLaunch(_url))
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readPref(),
        builder: (context, snapshot) {
          if (name != null) {
            return Scaffold(
              drawer: BuildSideMenu(routeName: CardCollectionScreen.id),
              appBar: AppBar(
                title: Text("Business Cards"),
              ),
              body: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10, //From database
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              height: 230,
                              width: double.maxFinite,
                              child: Card(
                                elevation: 5,
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
                                                personNameJobWidget(
                                                    name, title),
                                                companyNameWidget(company),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                //fittedbox here
                                                phoneWidget(phone),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                emailWidget(email),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                websiteWidget(website),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                linkedinWidget(linkedin)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
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
