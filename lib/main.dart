// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'homepage.dart';

void main() async {
  runApp(const MyApp());
}

//Hauptmethode der App
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), //Klasse Homepage aus 'homepage.dart'
    );
  }
}
