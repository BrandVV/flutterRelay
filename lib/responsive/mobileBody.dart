// ignore_for_file: file_names, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:app/pages/door.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/settings.dart';
import 'package:flutter/material.dart';

//storage.getItem('index')
//storage.setItem('index', 1);

class MyMobileBody extends StatelessWidget {
  int _selectedIndex = 0;
  dynamic _context;

  MyMobileBody({Key? key}) : super(key: key);

  void _navigateBottomBar(int index) {
    _selectedIndex = index;
    (_context as Element).markNeedsBuild();
  }

  final List<Widget> _pages = [
    const UserHome(),
    const UserDoor(),
    UserSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black45,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.door_front_door), label: 'Tür'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Einstellungen'),
        ],
      ),
    );
  }
}
