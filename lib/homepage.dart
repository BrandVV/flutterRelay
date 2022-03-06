import 'package:app/responsive/desktopBody.dart';
import 'package:app/responsive/mobileBody.dart';
import 'package:app/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(mobileBody: MyMobileBody(), desktopBody: const MyDesktopBody()), //Verschiedene Layouts für Bildschirmgrößen
    );
  }
}