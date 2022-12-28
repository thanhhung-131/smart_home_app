import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_home/services/auth/auth_service.dart';

import '../constants/routes.dart';
import '../enums/menu_action.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_switch/flutter_switch.dart';

// var url = 'http://192.168.0.104:8000/';
var url = 'http://192.168.0.104:5000/';

Future<Widget> living(BuildContext context, String path) async {
  final uri = Uri.parse(url + path);
  await http.get(uri);
  return const CircularProgressIndicator();
}

Future<Widget> gara(BuildContext context, String path) async {
  final uri = Uri.parse(url + path);
  await http.get(uri);
  return const CircularProgressIndicator();
}

Future<Widget> bedroom(BuildContext context, String path) async {
  final uri = Uri.parse(url + path);
  await http.get(uri);
  return const CircularProgressIndicator();
}

Future<Widget> toilet(BuildContext context, String path) async {
  final uri = Uri.parse(url + path);
  await http.get(uri);
  return const CircularProgressIndicator();
}

Future<Widget> fankitchen(BuildContext context, String path) async {
  final uri = Uri.parse(url + path);
  await http.get(uri);
  return const CircularProgressIndicator();
}

Future<Widget> fanbedroom(BuildContext context, String path) async {
  final uri = Uri.parse(url + path);
  await http.get(uri);
  return const CircularProgressIndicator();
}

// final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
//     foregroundColor: Colors.white,
//     backgroundColor: Colors.green[300],
//     minimumSize: const Size(80, 36),
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(Radius.circular(2)),
//     ));

class SmartHomeControls extends StatefulWidget {
  const SmartHomeControls({super.key});

  @override
  State<SmartHomeControls> createState() => _SmartHomeControlsState();
}

class _SmartHomeControlsState extends State<SmartHomeControls> {
  bool _living = false;
  bool _gara = false;
  bool _bedrom = false;
  bool _toilet = false;

  // Future<String> getTemp() async {
  //   String nhietdo = 'temperature: ';
  //   var client = HttpClient();
  //   var uri = Uri.parse(url);
  //   var request = await client.getUrl(uri);
  //   var response = await request.close();
  //   var responseBody = await response.transform(utf8.decoder).join();
  //   var start = responseBody.indexOf(nhietdo, 0);
  //   var end = responseBody.indexOf('\'C');
  //   String lt = responseBody.substring(start + nhietdo.length, end);
  //   return lt;
  // }

  // Future<String> getHumid() async {
  //   String doam = 'humidity: ';
  //   var client = HttpClient();
  //   var uri = Uri.parse(url);
  //   var request = await client.getUrl(uri);
  //   var response = await request.close();
  //   var responseBody = await response.transform(utf8.decoder).join();
  //   var start = responseBody.indexOf(doam, 0);
  //   var end = responseBody.indexOf('%');
  //   String lt = responseBody.substring(start + doam.length, end);
  //   return lt;
  // }

  // Future<String> getGas() async {
  //   String gas = 'gas: ';
  //   var client = HttpClient();
  //   var uri = Uri.parse(url);
  //   var request = await client.getUrl(uri);
  //   var response = await request.close();
  //   var responseBody = await response.transform(utf8.decoder).join();
  //   var start = responseBody.indexOf(gas, 0);
  //   var end = responseBody.indexOf('.');
  //   String lt = responseBody.substring(start + gas.length, end);
  //   return lt;
  // }

  // Future<String> getLight() async {
  //   String light = 'light: ';
  //   var client = HttpClient();
  //   var uri = Uri.parse(url);
  //   var request = await client.getUrl(uri);
  //   var response = await request.close();
  //   var responseBody = await response.transform(utf8.decoder).join();
  //   var start = responseBody.indexOf(light, 0);
  //   var end = responseBody.indexOf(',');
  //   String lt = responseBody.substring(start + light.length, end);
  //   return lt;
  // }

  // Timer timer = Timer(const Duration(seconds: 5), () {});

  Color c = const Color(0xFF42A5F5);

  // @override
  // void initialize() {
  //   setState(() {
  //     getTemp();
  //     getHumid();
  //     getLight();
  //     getGas();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Controller'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromARGB(255, 255, 235, 183),
                  boxShadow: const [
                    BoxShadow(color: Colors.white10, spreadRadius: 2),
                  ],
                ),
                margin: const EdgeInsets.all(4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        activeIcon: const Icon(Icons.light_mode),
                        borderRadius: 10.0,
                        activeColor: c,
                        value: _living,
                        onToggle: (value) {
                          if (value) {
                            setState(() {
                              _living = value;
                              living(context, 'living/on');
                            });
                          } else {
                            setState(() {
                              _living = value;
                              living(context, 'living/off');
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Living Room',
                          style: TextStyle(
                              color: Color.fromARGB(255, 49, 32, 224)))
                    ])),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromARGB(223, 95, 223, 218),
                  boxShadow: const [
                    BoxShadow(color: Colors.white10, spreadRadius: 2),
                  ],
                ),
                margin: const EdgeInsets.all(4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        activeIcon: const Icon(Icons.light_mode),
                        borderRadius: 10.0,
                        activeColor: c,
                        value: _gara,
                        onToggle: (value) {
                          if (value) {
                            setState(() {
                              _gara = value;
                              gara(context, 'gara/on');
                            });
                          } else {
                            setState(() {
                              _gara = value;
                              gara(context, 'gara/off');
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Gara')
                    ])),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromARGB(223, 95, 223, 218),
                  boxShadow: const [
                    BoxShadow(color: Colors.white10, spreadRadius: 2),
                  ],
                ),
                margin: const EdgeInsets.all(4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        activeIcon: const Icon(Icons.light_mode),
                        borderRadius: 10.0,
                        activeColor: c,
                        value: _bedrom,
                        onToggle: (value) {
                          if (value) {
                            setState(() {
                              _bedrom = value;
                              bedroom(context, 'bedroom/on');
                            });
                          } else {
                            setState(() {
                              _bedrom = value;
                              bedroom(context, 'bedroom/off');
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Bedroom')
                    ])),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromARGB(223, 95, 223, 218),
                  boxShadow: const [
                    BoxShadow(color: Colors.white10, spreadRadius: 2),
                  ],
                ),
                margin: const EdgeInsets.all(4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlutterSwitch(
                        height: 20.0,
                        width: 40.0,
                        padding: 4.0,
                        toggleSize: 15.0,
                        activeIcon: const Icon(Icons.light_mode),
                        borderRadius: 10.0,
                        activeColor: c,
                        value: _toilet,
                        onToggle: (value) {
                          if (value) {
                            setState(() {
                              _toilet = value;
                              toilet(context, 'toilet/on');
                            });
                          } else {
                            setState(() {
                              _toilet = value;
                              toilet(context, 'toilet/off');
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Toilet')
                    ])),
            // FutureBuilder(
            //     future: getTemp(),
            //     builder: (BuildContext context, AsyncSnapshot<String> text) {
            //         if (text.hasData) {
            //           return Text("Gas: ${text.data}");
            //         }
            //         if (text.hasError) {
            //           return Text(text.error.toString());
            //         } else {
            //           return const CircularProgressIndicator();
            //         }
            //     }),
            // FutureBuilder(
            //     future: getHumid(),
            //     builder: (BuildContext context, AsyncSnapshot<String> text) {
            //         if (text.hasData) {
            //           return Text("Humidity: ${text.data}%");
            //         }
            //         if (text.hasError) {
            //           return Text(text.error.toString());
            //         } else {
            //           return const CircularProgressIndicator();
            //       }
            //     }),
            // FutureBuilder(
            //     future: getGas(),
            //     builder: (BuildContext context, AsyncSnapshot<String> text) {
            //         if (text.hasData) {
            //           return Text("Gas: ${text.data}");
            //         }
            //         if (text.hasError) {
            //           return Text(text.error.toString());
            //         } else {
            //           return const CircularProgressIndicator();
            //         }
            //     }),
            // FutureBuilder(
            //     future: getLight(),
            //     builder: (BuildContext context, AsyncSnapshot<String> text) {
            //       if (text.hasData) {
            //         return Text("Gas: ${text.data}");
            //       }
            //       if (text.hasError) {
            //         return Text(text.error.toString());
            //       } else {
            //         return const CircularProgressIndicator();
            //       }
            //     })
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log out'),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}
