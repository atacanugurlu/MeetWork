import 'dart:convert';
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
import 'package:meetwork/components/shared_pref.dart';

class CardCollectionScreen extends StatefulWidget {
  static const id = 'card_collection_screen';

  @override
  _CardCollectionScreenState createState() => _CardCollectionScreenState();
}

class _CardCollectionScreenState extends State<CardCollectionScreen> {
  SharedPref sharedPref = SharedPref();

  BusinessCardInfo savedCardDetails = BusinessCardInfo();

  loadSharedPrefs() async {
    try {
      BusinessCardInfo card =
          BusinessCardInfo.fromJson(await sharedPref.readPref("card"));

      setState(() {
        savedCardDetails = card;
      });
    } catch (Excepetion) {
      print("Exception occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    Map cardInfo = ModalRoute.of(context).settings.arguments;
    BusinessCardInfo cardDetails = BusinessCardInfo.fromJson(cardInfo);
    sharedPref.savePref("card", cardDetails);
    loadSharedPrefs();

    return Scaffold(
      drawer: BuildSideMenu(routeName: CardCollectionScreen.id),
      appBar: AppBar(
        title: Text("Your Business Card"),
      ),
      body: Container(
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
                          personNameJob(savedCardDetails),
                          companyName(savedCardDetails),
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
                          //fittedbox here
                          phone(savedCardDetails),
                          SizedBox(
                            height: 5,
                          ),
                          email(savedCardDetails),
                          SizedBox(
                            height: 5,
                          ),
                          website(savedCardDetails),
                          SizedBox(
                            height: 5,
                          ),
                          linkedin(savedCardDetails)
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
    );
  }
}

Widget personNameJob(BusinessCardInfo cardInfo) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: 150,
      child: RichText(
        text: TextSpan(
          text: cardInfo.name,
          style: GoogleFonts.raleway(
              fontStyle: FontStyle.italic, color: Colors.black, fontSize: 23),
          children: <TextSpan>[
            TextSpan(
                text: "\n" + cardInfo.title,
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

Widget companyName(BusinessCardInfo cardInfo) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: GestureDetector(
      onTap: () {
        location(cardInfo.company);
      },
      child: Container(
        width: 140,
        child: Text(
          cardInfo.company,
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

Widget phone(BusinessCardInfo cardInfo) {
  return GestureDetector(
    onTap: () {
      phoneCall(cardInfo.phone);
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
                  text: cardInfo.phone,
                  style: GoogleFonts.lato(fontSize: 8, color: Colors.black))),
        ),
      ],
    ),
  );
}

Widget email(BusinessCardInfo cardInfo) {
  return GestureDetector(
    onTap: () {
      sendEmail(cardInfo.email);
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
                  text: cardInfo.email,
                  style: GoogleFonts.lato(fontSize: 8, color: Colors.black))),
        ),
      ],
    ),
  );
}

Widget website(BusinessCardInfo cardInfo) {
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
                  text: cardInfo.website,
                  style: GoogleFonts.lato(fontSize: 8, color: Colors.black))),
        ),
      ],
    ),
  );
}

Widget linkedin(BusinessCardInfo cardInfo) {
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
                  text: cardInfo.linkedin,
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

const _url = 'https://linkedin.com';
void launchURL() async => (await canLaunch(_url))
    ? await launch(_url)
    : throw 'Could not launch $_url';
