import 'package:flutter/material.dart';
import 'package:meetwork/components/side_menu.dart';

class QRCodeScreen extends StatefulWidget {
  static const id = 'qr_code_screen';
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildSideMenu(routeName: QRCodeScreen.id),
      appBar: AppBar(
        title: Text("Get MeetWork"),
      ),
    );
  }

  buildCard(BuildContext context, int index) {}
}
