import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/components/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:meetwork/business_card_class.dart';
import 'package:nfc_manager/nfc_manager.dart';

class CardCollectionScreen extends StatefulWidget {
  static const id = 'card_collection_screen';

  @override
  _CardCollectionScreenState createState() => _CardCollectionScreenState();
}

class _CardCollectionScreenState extends State<CardCollectionScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  void _addCard(BusinessCardInfo card) async {
    await _databaseHelper.insert(card);
    setState(() {
      getCards();
    });
  }

  void _deleteCard(int deletedCardId, int deletedCardIndex) async {
    await _databaseHelper.delete(deletedCardId);

    setState(() {
      getCards();
    });
  }

  BusinessCardInfo atacan = BusinessCardInfo(3, "Atacan Ugurlu3", "title",
      "company", "phone", "email", "website", "linkedin");

  BusinessCardInfo atacan1 = BusinessCardInfo(4, "Atacan4 LALAL", "VOLOLO",
      "company", "phone", "email", "website", "linkedin");

  List<BusinessCardInfo> allCards = [];

  Future<String> getCards() async {
    var cardsFuture = _databaseHelper.getAllCards();
    await cardsFuture.then((value) => {
          setState(() {
            this.allCards = value;
          })
        });
    return "Accomplished";
  }

  @override
  void initState() {
    super.initState();
    //_addCard(atacan);
    //_addCard(atacan1);
    getCards();
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

  Widget deleteCardWidget(int cardID) {
    return GestureDetector(
      onTap: () {
        _databaseHelper.delete(cardID);
      },
      child: RichText(
        text: TextSpan(
            text: "Delete",
            style: TextStyle(
                color: Colors.orange, decoration: TextDecoration.underline)),
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
        future: getCards(),
        builder: (context, snapshot) {
          if (allCards.length > 0) {
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
                          itemCount: allCards.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              height: 230,
                              width: double.maxFinite,
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.orange,
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: <Widget>[
                                          Stack(
                                            children: [
                                              personNameJobWidget(
                                                  allCards[index].name,
                                                  allCards[index].title),
                                              companyNameWidget(
                                                  allCards[index].company),
                                            ],
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
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: deleteCardWidget(
                                                    allCards[index].cardID)),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                phoneWidget(
                                                    allCards[index].phone),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                emailWidget(
                                                    allCards[index].email),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                websiteWidget(
                                                    allCards[index].website),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                linkedinWidget(
                                                    allCards[index].linkedin)
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Icon(
                          FontAwesomeIcons.sadTear,
                          size: 60,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "No Cards",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                      ],
                    )));
          }
        });
  }
}
