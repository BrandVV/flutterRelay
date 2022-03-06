// ignore_for_file: must_be_immutable

import 'package:app/pages/door.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHome extends StatelessWidget {
  late String darkmode;
  UserHome({Key? key, required this.darkmode}) : super(key: key);

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
                          "Home",
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
                        createButton(context, "Einstellungen", "settings", returnDarkmodeButtonColor(darkmode)),
                        const SizedBox(height: 40),
                        createButton(context, "Tür - Steuerung", "door", returnDarkmodeButtonColor(darkmode)),
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
                        const SizedBox(height: 30),
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
        height: 50,
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
              final prefs = await SharedPreferences.getInstance();
              dynamic value = prefs.getString("darkmode") ?? 0;
              if (value.toString() == "0") {
                value = "Darkmode: Off";
              }
              if (value.toString() == "1") {
                value = "Darkmode: On";
              }
              if (ziel == "settings") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserSettings(darkmode: value.toString())));
              } else if (ziel == "door") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserDoor(darkmode: value.toString())));
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