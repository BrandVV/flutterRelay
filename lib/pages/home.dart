import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Home - Seite",
        style: TextStyle(fontSize: 50),
      )
    );
  }
}