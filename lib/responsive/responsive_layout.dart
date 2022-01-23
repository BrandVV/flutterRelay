// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {

  late final Widget mobileBody;
  late final Widget desktopBody;

  ResponsiveLayout({Key? key, required this.mobileBody, required this.desktopBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      }
    );
  }
}