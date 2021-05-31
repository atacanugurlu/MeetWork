import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/screens/sub_screens/business_card_screen.dart';
import 'package:meetwork/screens/sub_screens/share_card_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:meetwork/business_card_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCardScreen extends StatefulWidget {
  static const id = 'my_card_screen';

  @override
  _MyCardScreenState createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
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
    var myCardJSON = json.decode(prefs.getString("myCard"));
    BusinessCardInfo myCard = BusinessCardInfo.fromMap(myCardJSON);
    name = myCard.name;
    title = myCard.title;
    company = myCard.company;
    phone = myCard.phone;
    email = myCard.email;
    website = myCard.website;
    linkedin = myCard.linkedin;
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
              drawer: BuildSideMenu(routeName: MyCardScreen.id),
              appBar: AppBar(
                title: Text("Your Business Card"),
              ),
              body: Column(
                children: [
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
                                      personNameJobWidget(name, title),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, ShareCardScreen.id);
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shadowColor: Colors.orange,
                          elevation: 15,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(10, 15)))),
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: RichText(
                          text: TextSpan(
                              text: "Share Card",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))))
                ],
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
