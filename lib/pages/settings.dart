// ignore_for_file: avoid_print, must_be_immutable, non_constant_identifier_names, unused_field

import 'dart:core';
import 'package:app/pages/door.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings extends StatefulWidget {
  late String darkmode;

  UserSettings({Key? key, required this.darkmode}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettings();
}

class _UserSettings extends State<UserSettings> {
  int value = 0;
  String underTitel = "Aktion wählen";
  //String buttonText = "Darkmode: Test"; //widget.darkmode;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
                      color: returnDarkmodeColor(widget.darkmode), //Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Einstellungen",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: returnDarkmodeTextColor(widget.darkmode),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          underTitel,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomRadioButton(widget.darkmode, 1),
                        const SizedBox(height: 80),
                        createButton(context, "Home", "home", returnDarkmodeButtonColor(widget.darkmode)),
                        const SizedBox(height: 40),
                        createButton(context, "Tür - Steuerung", "door", returnDarkmodeButtonColor(widget.darkmode)),
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
            onTap: () {
              //print("hi");
              if (ziel == "home") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome(darkmode: widget.darkmode)));
              } else if (ziel == "door") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserDoor(darkmode: widget.darkmode)));
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

  readData(String dataKey) async {
    final prefs = await SharedPreferences.getInstance();
    final key = dataKey;
    final value = prefs.getString(key) ?? 0;
    return value;
  }

  saveData(String _dataKey, String _data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _dataKey;
    final data = _data;
    final value = prefs.setString(key, data);
    return value;
  }

  Widget CustomRadioButton(String text, int index) {
    print(text);
    if (text == "Darkmode: Off") {
      setState(() {
        value = index;
      });
      UserSettings(darkmode: widget.darkmode);
    }

    // ignore: deprecated_member_use
    return OutlineButton(
      onPressed: () async {
        print(value);
        if (value != index) {
          await saveData("darkmode", "0");
          setState(() {
            value = index;
            widget.darkmode = "Darkmode: Off";
            print("Darkmode-State: " + widget.darkmode);
            UserSettings(darkmode: widget.darkmode);
          });
        } else {
          await saveData("darkmode", "1");
          setState(() {
            value = 0;
            widget.darkmode = "Darkmode: On";
            UserSettings(darkmode: widget.darkmode);
          });
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.black : Colors.green,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide:
          BorderSide(color: (value == index) ? Colors.green : Colors.white),
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
