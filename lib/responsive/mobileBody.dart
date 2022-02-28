// ignore_for_file: file_names, prefer_typing_uninitialized_variables, must_be_immutable, avoid_print

import 'dart:convert';

import '../pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//storage.getItem('index')

getUserData() async {
  final response = await http.post(
    Uri.parse(
        'https://my-json-server.typicode.com/typicode/demo/posts/1'), //http://192.168.178.64:80/getUserInfo.php
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({
      "id": "1",
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Fehler");
  }
}

class MyMobileBody extends StatelessWidget {
  dynamic username;

  MyMobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Login()),
    );
  }
}
