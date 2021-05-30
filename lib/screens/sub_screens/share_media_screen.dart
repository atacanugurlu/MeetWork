import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetwork/components/side_menu.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/sub_screens/business_card_screen.dart';
import 'package:meetwork/screens/sub_screens/card_collection_screen.dart';
import 'package:meetwork/screens/sub_screens/my_card_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShareMediaScreen extends StatefulWidget {
  static const id = 'share_media_screen';

  @override
  _ShareMediaScreenState createState() => _ShareMediaScreenState();
}

class _ShareMediaScreenState extends State<ShareMediaScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share Media Accounts"),
      ),
      body: Text("Open NFC"),
    );
  }
}
