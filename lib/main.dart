// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final dynamic value = prefs.getString("darkmode") ?? 0;
  final String autoLogin = prefs.getString("autoLogin").toString();

  runApp(MyApp(darkmode: value, autoLogin: autoLogin));
}

//Hauptmethode der App
class MyApp extends StatelessWidget {
  late String darkmode;
  late String autoLogin;
  MyApp({Key? key, required this.darkmode, required this.autoLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(darkmode: darkmode, autoLogin: autoLogin), //Klasse Homepage aus 'homepage.dart'
    );
  }
}
