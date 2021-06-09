import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetwork/constants.dart';
import 'package:meetwork/screens/sub_screens/business_screens/business_card_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meetwork/components/business_card_class.dart';
import 'dart:math';
import 'package:nearby_connections/nearby_connections.dart';
import 'dart:io';

class ShareCardScreen extends StatefulWidget {
  static const id = 'share_card_screen';

  @override
  _ShareCardScreenState createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends State<ShareCardScreen> {
  int counter;
  int cardId;
  String name;
  String title;
  String company;
  String phone;
  String email;
  String website;
  String linkedin;
  var cardJSON;

  final String userName = Random().nextInt(10000).toString();
  final Strategy strategy = Strategy.P2P_STAR;
  Map<String, ConnectionInfo> endpointMap = Map();

  File tempFile;
  Map<int, String> map = Map();

  @override
  void initState() {
    super.initState();
    getCounter();
    readPref().then((value) {
      if (name == null) {
        Navigator.pushNamed(context, BusinessCardScreen.id);
      }
    });
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

  Future<String> readPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cardJSON = prefs.getString("myCard");
    var myCardJSON = json.decode(cardJSON);

    BusinessCardInfo myCard = BusinessCardInfo.fromMap(myCardJSON);
    cardId = counter;
    name = myCard.name;
    title = myCard.title;
    company = myCard.company;
    phone = myCard.phone;
    email = myCard.email;
    website = myCard.website;
    linkedin = myCard.linkedin;
    return "Done";
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readPref(),
        builder: (context, snapshot) {
          if (name != null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: sideMenuColor,
                title: Text("Share Card"),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                              text: "Permissions",
                              style: TextStyle(
                                  color: sideMenuColor2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      Column(
                        children: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Check Location Permission"),
                            onPressed: () async {
                              if (await Nearby().checkLocationPermission()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Location permission granted")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Location permission NOT granted")));
                              }
                            },
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Ask Location Permission",
                                style: TextStyle(color: Colors.orange)),
                            onPressed: () async {
                              if (await Nearby().askLocationPermission()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Location permission granted")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Location permission NOT granted")));
                              }
                            },
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Check External Storage Permission"),
                            onPressed: () async {
                              if (await Nearby()
                                  .checkExternalStoragePermission()) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "External storage permission granted")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "External storage permission NOT granted")));
                              }
                            },
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text(
                              "Ask External Storage Permission",
                              style: TextStyle(color: Colors.orange),
                            ),
                            onPressed: () {
                              Nearby().askExternalStoragePermission();
                            },
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.2,
                        color: sideMenuColor2,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Location",
                              style: TextStyle(
                                  color: sideMenuColor2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      Column(
                        children: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Check Location Enabled"),
                            onPressed: () async {
                              if (await Nearby().checkLocationEnabled()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Location is ON")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Location is OFF")));
                              }
                            },
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Enable Location Services",
                                style: TextStyle(color: Colors.orange)),
                            onPressed: () async {
                              if (await Nearby().enableLocationServices()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Location Service Enabled")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Enabling Location Service Failed")));
                              }
                            },
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.2,
                        color: sideMenuColor2,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "User Name: " + userName,
                              style: TextStyle(
                                  color: sideMenuColor2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Search Devices",
                                style: TextStyle(color: Colors.orange)),
                            onPressed: () async {
                              try {
                                bool a = await Nearby().startAdvertising(
                                  userName,
                                  strategy,
                                  onConnectionInitiated: onConnectionInit,
                                  onConnectionResult: (id, status) {
                                    showSnackbar(status);
                                  },
                                  onDisconnected: (id) {
                                    showSnackbar(
                                        "Disconnected: ${endpointMap[id].endpointName}, id $id");
                                    setState(() {
                                      endpointMap.remove(id);
                                    });
                                  },
                                );
                                showSnackbar(": " + a.toString());
                              } catch (exception) {
                                showSnackbar(exception);
                              }
                            },
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Stop Searching for Devices",
                                style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              await Nearby().stopAdvertising();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Become Visible",
                                style: TextStyle(color: Colors.orange)),
                            onPressed: () async {
                              try {
                                bool a = await Nearby().startDiscovery(
                                  userName,
                                  strategy,
                                  onEndpointFound: (id, name, serviceId) {
                                    // show sheet automatically to request connection
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return Center(
                                          child: Column(
                                            children: <Widget>[
                                              Text("id: " + id),
                                              Text("Name: " + name),
                                              Text("ServiceId: " + serviceId),
                                              ElevatedButton(
                                                child:
                                                    Text("Request Connection"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Nearby().requestConnection(
                                                    userName,
                                                    id,
                                                    onConnectionInitiated:
                                                        (id, info) {
                                                      onConnectionInit(
                                                          id, info);
                                                    },
                                                    onConnectionResult:
                                                        (id, status) {
                                                      showSnackbar(status);
                                                    },
                                                    onDisconnected: (id) {
                                                      setState(() {
                                                        endpointMap.remove(id);
                                                      });
                                                      showSnackbar(
                                                          "Disconnected from: ${endpointMap[id].endpointName}, id $id");
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  onEndpointLost: (id) {
                                    showSnackbar(
                                        "Lost discovered Endpoint: ${endpointMap[id].endpointName}, id $id");
                                  },
                                );
                                showSnackbar("DISCOVERING: " + a.toString());
                              } catch (e) {
                                showSnackbar(e);
                              }
                            },
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(sideMenuColor2)),
                            child: Text("Become Invisible",
                                style: TextStyle(color: Colors.red)),
                            onPressed: () async {
                              await Nearby().stopDiscovery();
                            },
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.2,
                        color: sideMenuColor2,
                      ),
                      RichText(
                          text: TextSpan(
                              text:
                                  "Number of connected devices: ${endpointMap.length}",
                              style: TextStyle(
                                  color: sideMenuColor2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0))),
                            backgroundColor:
                                MaterialStateProperty.all(sideMenuColor2)),
                        child: Text("Share Card",
                            style: TextStyle(color: Colors.orange)),
                        onPressed: () async {
                          PickedFile file = await ImagePicker()
                              .getImage(source: ImageSource.gallery);

                          if (file == null) return;

                          for (MapEntry<String, ConnectionInfo> m
                              in endpointMap.entries) {
                            int payloadId = await Nearby()
                                .sendFilePayload(m.key, file.path);
                            showSnackbar("Sending file to ${m.key}");
                            Nearby().sendBytesPayload(
                                m.key,
                                Uint8List.fromList(
                                    "$payloadId:${file.path.split('/').last}"
                                        .codeUnits));
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0))),
                            backgroundColor:
                                MaterialStateProperty.all(sideMenuColor2)),
                        child: Text("Stop All Connections",
                            style: TextStyle(color: Colors.red)),
                        onPressed: () async {
                          await Nearby().stopAllEndpoints();
                          setState(() {
                            endpointMap.clear();
                          });
                        },
                      ),
                    ],
                  ),
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

  void showSnackbar(dynamic a) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(a.toString()),
    ));
  }

  /// Called upon Connection request (on both devices)
  /// Both need to accept connection to start sending/receiving
  void onConnectionInit(String id, ConnectionInfo info) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Center(
          child: Column(
            children: <Widget>[
              Text("id: " + id),
              Text("Token: " + info.authenticationToken),
              Text("Name" + info.endpointName),
              Text("Incoming: " + info.isIncomingConnection.toString()),
              ElevatedButton(
                child: Text("Accept Connection"),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    endpointMap[id] = info;
                  });
                  Nearby().acceptConnection(
                    id,
                    onPayLoadRecieved: (endid, payload) async {
                      if (payload.type == PayloadType.BYTES) {
                        String str = String.fromCharCodes(payload.bytes);
                        showSnackbar(endid + ": " + str);

                        if (str.contains(':')) {
                          // used for file payload as file payload is mapped as
                          // payloadId:filename
                          int payloadId = int.parse(str.split(':')[0]);
                          String fileName = (str.split(':')[1]);

                          if (map.containsKey(payloadId)) {
                            if (await tempFile.exists()) {
                              tempFile.rename(
                                  tempFile.parent.path + "/" + fileName);
                            } else {
                              showSnackbar("Card doesn't exist");
                            }
                          } else {
                            //add to map if not already
                            map[payloadId] = fileName;
                          }
                        }
                      } else if (payload.type == PayloadType.FILE) {
                        showSnackbar(endid + ": Sharing Card");
                        tempFile = File(payload.filePath);
                      }
                    },
                    onPayloadTransferUpdate: (endid, payloadTransferUpdate) {
                      if (payloadTransferUpdate.status ==
                          PayloadStatus.IN_PROGRESS) {
                        print(payloadTransferUpdate.bytesTransferred);
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.FAILURE) {
                        print("failed");
                        showSnackbar(endid + ": FAILED to share card");
                      } else if (payloadTransferUpdate.status ==
                          PayloadStatus.SUCCESS) {
                        showSnackbar(
                            "$endid success, total bytes = ${payloadTransferUpdate.totalBytes}");

                        if (map.containsKey(payloadTransferUpdate.id)) {
                          //rename the file now
                          String name = map[payloadTransferUpdate.id];
                          tempFile.rename(tempFile.parent.path + "/" + name);
                        } else {
                          //bytes not received till yet
                          map[payloadTransferUpdate.id] = "";
                        }
                      }
                    },
                  );
                },
              ),
              ElevatedButton(
                child: Text("Reject Connection"),
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await Nearby().rejectConnection(id);
                  } catch (e) {
                    showSnackbar(e);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
