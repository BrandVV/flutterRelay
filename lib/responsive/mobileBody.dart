// ignore_for_file: file_names, prefer_typing_uninitialized_variables, must_be_immutable, avoid_print

import '../pages/login.dart';
import 'package:flutter/material.dart';

//storage.getItem('index')

class MyMobileBody extends StatelessWidget {
  dynamic username;
  late String darkmode;
  late String autoLogin;

  MyMobileBody({Key? key, required this.darkmode, required this.autoLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Login(darkmode: darkmode, autoLogin: autoLogin)),
    );
  }
}
