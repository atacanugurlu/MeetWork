import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/sub_screens/business_card_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meetwork/business_card_class.dart';

class ShareCardScreen extends StatefulWidget {
  static const id = 'share_card_screen';

  @override
  _ShareCardScreenState createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends State<ShareCardScreen> {
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

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readPref(),
        builder: (context, snapshot) {
          if (name != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Share Business Card"),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitFadingCircle(
                    size: 80,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? sideMenuColor2 : Colors.orange,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Stack(
                    children: <Widget>[                      
                      Text(
                        'Open NFC\nGet phones together',
                        style: TextStyle(
                          fontSize: 36,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = sideMenuColor2,
                        ),
                      ),                    
                      Text(
                        'Open NFC\nGet phones together',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  )
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
