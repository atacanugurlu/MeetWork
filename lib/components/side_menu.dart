import 'package:flutter/material.dart';
import 'package:meetwork/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/screens/main_screens/qr_code_screen.dart';
import 'package:meetwork/screens/main_screens/social_media_screen.dart';
import 'package:meetwork/screens/main_screens/opening_screen.dart';
import 'package:meetwork/screens/main_screens/business_screen.dart';

class BuildSideMenu extends StatefulWidget {
  final String routeName;
  BuildSideMenu({@required this.routeName});
  @override
  _BuildSideMenuState createState() => _BuildSideMenuState();
}

enum Screen { home, social, business, qrcode }

class _BuildSideMenuState extends State<BuildSideMenu> {
  Color activeColor = basePurple;
  Color inactiveColor = sideMenuColor;
  Screen selectedScreen;
  void updateColor(String routeName) {
    if (routeName == OpeningScreen.id) {
      selectedScreen = Screen.home;
    } else if (routeName == SocialMediaScreen.id) {
      selectedScreen = Screen.social;
    } else if (routeName == BusinessScreen.id) {
      selectedScreen = Screen.business;
    } else if (routeName == QRCodeScreen.id) {
      selectedScreen = Screen.qrcode;
    }
  }

  @override
  void initState() {
    super.initState();
    updateColor(widget.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: Container(
          color: sideMenuColor2,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                color: sideMenuColor,
                child: DrawerHeader(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  padding: EdgeInsets.zero,
                  child: Stack(children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/images/meetwork_logo.png')),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(text: 'Atacan Uğurlu')),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SideMenuCard(
                  menuLabel: "Main Page",
                  iconType: Icons.home,
                  color: selectedScreen == Screen.home
                      ? activeColor
                      : inactiveColor,
                  navigation: () {
                    setState(() {
                      Navigator.popUntil(
                          context, ModalRoute.withName(OpeningScreen.id));
                      Navigator.pushNamed(context, OpeningScreen.id);
                    });
                  }),
              SideMenuCard(
                  menuLabel: "Social Media",
                  iconType: FontAwesomeIcons.user,
                  color: selectedScreen == Screen.social
                      ? activeColor
                      : inactiveColor,
                  navigation: () {
                    setState(() {
                      Navigator.popUntil(
                          context, ModalRoute.withName(OpeningScreen.id));
                      Navigator.pushNamed(context, SocialMediaScreen.id);
                    });
                  }),
              SideMenuCard(
                  menuLabel: "Business",
                  iconType: FontAwesomeIcons.briefcase,
                  color: selectedScreen == Screen.business
                      ? activeColor
                      : inactiveColor,
                  navigation: () {
                    setState(() {
                      Navigator.popUntil(
                          context, ModalRoute.withName(OpeningScreen.id));
                      Navigator.pushNamed(context, BusinessScreen.id);
                    });
                  }),
              SideMenuCard(
                  menuLabel: "Invite People",
                  iconType: FontAwesomeIcons.download,
                  color: selectedScreen == Screen.qrcode
                      ? activeColor
                      : inactiveColor,
                  navigation: () {
                    setState(() {
                      Navigator.popUntil(
                          context, ModalRoute.withName(OpeningScreen.id));
                      Navigator.pushNamed(context, QRCodeScreen.id);
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenuCard extends StatelessWidget {
  SideMenuCard(
      {@required this.menuLabel,
      @required this.iconType,
      @required this.navigation,
      @required this.color});
  final String menuLabel;
  final IconData iconType;
  final Function navigation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      margin: EdgeInsets.all(4),
      child: ListTile(
        onTap: navigation,
        leading: Icon(
          iconType,
          color: Colors.orange.withAlpha(500),
          size: 25.0,
        ),
        title: Text(
          menuLabel,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
