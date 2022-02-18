// ignore_for_file: avoid_print, must_be_immutable, non_constant_identifier_names, unused_field

import 'dart:convert';
import 'dart:core';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Text("Test"),
    );
  }
}
