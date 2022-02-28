// ignore_for_file: avoid_print, must_be_immutable, non_constant_identifier_names, unused_field

import 'dart:convert';
import 'dart:core';
import 'package:app/pages/door.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

getUserData() async {
  final response = await http.get(
    Uri.parse(
        'https://my-json-server.typicode.com/typicode/demo/posts/1'), //http://192.168.178.64:80/getUserInfo.php
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    //body: jsonEncode({
    //  "id": "1",
    //})
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Fehler beim Abgleich der Daten");
  }
}

class UserSettings extends StatelessWidget {
  const UserSettings({Key? key}) : super(key: key);

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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
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
                        createButton(context, "Home", "home"),
                        const SizedBox(height: 80),
                        createButton(context, "Tür - Steuerung", "door"),
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

  createButton(context, String text, String ziel) {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserHome()));
              } else if (ziel == "door") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserDoor()));
              }
            },
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
