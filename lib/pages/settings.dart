// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class UserSettings extends StatelessWidget {
  UserSettings({Key? key}) : super(key: key);

  static final LocalStorage storage = LocalStorage('localstorage_app');

  bool _valueDarkMode = false;

  @override
  Widget build(BuildContext context) {
    storage.setItem('darkMode', false);
    _valueDarkMode = storage.getItem('darkMode');
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(30.0)),
        const Center(
          child: Text(
            "Settings - Seite",
            style: TextStyle(fontSize: 50),
          ),
        ),
        const Padding(padding: EdgeInsets.all(50.0)),
        Checkbox(
          value: _valueDarkMode,
          onChanged: (value) {
            print("Test");
          },
        ),
      ],
    );
  }
}