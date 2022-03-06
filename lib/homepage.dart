// ignore_for_file: must_be_immutable

import 'package:app/responsive/desktopBody.dart';
import 'package:app/responsive/mobileBody.dart';
import 'package:app/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  late String darkmode;
  late String autoLogin;
  HomePage({Key? key, required this.darkmode, required this.autoLogin}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(mobileBody: MyMobileBody(darkmode: widget.darkmode, autoLogin: widget.autoLogin), desktopBody: MyDesktopBody(darkmode: widget.darkmode, autoLogin: widget.autoLogin)), //Verschiedene Layouts für Bildschirmgrößen
    );
  }
}