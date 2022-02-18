// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<StartInfo> getUserData() async {
  final response = await http.get(
    Uri.parse(
        'https://my-json-server.typicode.com/typicode/demo/posts/1'), //http://192.168.178.64:80/getUserInfo.php
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    //body: jsonEncode({
    //  "id": "1",
    //})
  );

  if (response.statusCode == 200) {
    return StartInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Fehler beim Abgleich der Daten");
  }
}

class StartInfo {
  final dynamic id;
  final String username;
  Future<StartInfo>? futureUserInfo_;

  StartInfo({required this.id, required this.username});

  factory StartInfo.fromJson(Map<String, dynamic> Json) {
    return StartInfo(
      id: Json['id'],
      username: Json['title'],
    );
  }

  FutureBuilder<StartInfo> buildFutureBuilder() {
    return FutureBuilder<StartInfo>(
      future: futureUserInfo_,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return Text(snapshot.data!.username);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
