// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, avoid_print, unnecessary_null_comparison

import 'dart:convert';

import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDoor extends StatelessWidget {
  late String darkmode;
  UserDoor({Key? key, required this.darkmode}) : super(key: key);

  final doorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8A2387),
                    Color(0xFFE94057),
                    Color(0xFFF27121),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  //Image.asset("images/logo.png"),
                  const SizedBox(height: 15),
                  //const Text(
                  //  "Informatik - AG",
                  //  style: TextStyle(
                  //    color: Colors.white,
                  //    fontSize: 20,
                  //  ),
                  //),
                  const SizedBox(height: 30),
                  Container(
                    height: 480,
                    width: 325,
                    decoration: BoxDecoration(
                      color: returnDarkmodeColor(darkmode),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Steuerung",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: returnDarkmodeTextColor(darkmode),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Aktion wählen",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 80),
                        Container(
                          width: 250,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: doorController,
                            decoration: InputDecoration(
                              labelText: "Öffnungs-Zeit (maximal 5)",
                              labelStyle: TextStyle(color: returnDarkmodeTextColor(darkmode)),
                              suffixIcon: const Icon(Icons.book_online , size: 17),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        createButton(context, "Öffnen", "open_door", returnDarkmodeButtonColor(darkmode)),
                        const SizedBox(height: 50),
                        createButton(context, "Home", "home", returnDarkmodeButtonColor(darkmode)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              //Text(
                              //  "Passwort vergessen?",
                              //  style: TextStyle(
                              //    color: Colors.orangeAccent,
                              //  ),
                              //),
                            ],
                          ),
                        ),
                        //const SizedBox(height: 20),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

  createButton(context, String text, String ziel, Color textFarbe) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF8A2387),
              Color(0xFFE94057),
              Color(0xFFF27121),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () async {
              //print("hi");
              if (ziel == "home") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome(darkmode: darkmode)));
              } else if (ziel == "open_door") {
                if (doorController.text == null) {
                  getAlert(context, "Fehler", "Du musst eine Zeit angeben");
                } else if (doorController.text == "") {
                  getAlert(context, "Fehler", "Du musst eine Zeit angeben");
                } else if (doorController.text != "" && doorController.text != null) {
                  var response = await openDoor(context, doorController.text);
                  if (response == 404) {
                    response ??= "Unbekannt";
                    getAlert(context, "Fehler: $response", "Die API hat den Fehlercode: *$response* zurückgegeben. Bitte kontaktieren Sie den Entwickler");
                  }
                }
              }
            },
            child: Text(
              text,
              style: TextStyle(
                color: textFarbe,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  openDoor(context, String zeit) async {
    var zeit_int = int.parse(zeit);
    print(zeit_int);
    if (zeit == null) {
      getAlert(context, "Fehler", "Du musst eine Zeit angeben");
    }
    if (zeit != "" && zeit_int != 0) {
      if (zeit_int > 5) {
        getAlert(context, "Fehler", "Die Zeit darf nicht länger als 5 Sekunden sein");
      } else {
        if (zeit_int < 0) {
        getAlert(context, "Fehler", "Die Zeit muss länger als 1 sein");
      } else {
        try {
          final response = await http.post(
            Uri.parse(
                'url/relay/0?turn=on&timer=$zeit'), //url/getUserInfo.php || url/relay/0?turn=on&timer=$zeit
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              "id": "1",
              "zeit": zeit,
            })
          );
          if (response.statusCode == 200 || response.statusCode == 201) {
            getAlert(context, "Erfolg: ${response.statusCode}", "Die Tür ist gleich offen");
            return response.statusCode;
          } else {
            print(response.statusCode);
            getAlert(context, "Fehler: ${response.statusCode}", "Die API hat den Fehlercode: ${response.statusCode} zurückgegeben. Bitte kontaktieren Sie Niklas");
          }
        } on Exception {
          return 404;
        }
      }
      }
    } else {
      getAlert(context, "Fehler", "Du musst eine Zeit angeben");
    }
  }

  getAlert(_context, String titel, String text) {
    return showDialog(
      context: _context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color(0xFFF27121),
        title: Text(titel),
        content: Text(text),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  returnDarkmodeColor(String darkmode) {
    print("Home - Darkmode: " + darkmode);
    if (darkmode == "0" || darkmode == "Darkmode: Off") {
      return Colors.white;
    }
    if (darkmode == "1" || darkmode == "Darkmode: On") {
      return const Color.fromARGB(255, 39, 39, 39);
    }
  }

  returnDarkmodeTextColor(String darkmode) {
    if (darkmode == "0" || darkmode == "Darkmode: Off") {
      return Colors.black;
    }
    if (darkmode == "1" || darkmode == "Darkmode: On") {
      return Colors.white;
    }
  }

  Color returnDarkmodeButtonColor(String darkmode) {
    Color color = Colors.white;
    if (darkmode == "0" || darkmode == "Darkmode: Off") {
      color = Colors.white;
    }
    if (darkmode == "1" || darkmode == "Darkmode: On") {
      color = const Color.fromARGB(255, 39, 39, 39);
    }
    return color;
  }
}
