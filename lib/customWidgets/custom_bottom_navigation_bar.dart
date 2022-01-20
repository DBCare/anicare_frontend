import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/functions/auth.dart';
import 'package:untitled/pages/ingredien_analysis.dart';
import 'package:untitled/pages/main_menu.dart';
import 'package:untitled/pages/main_screen.dart';
import 'package:untitled/pages/user_profile.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final screens = [
    const MainMenu(),
    const IngredientAnalysis(),
    Auth.getCurrUser() != null ? const UserProfile() : const MainScreen()
  ];
  int _selectedIndex = 0;
  _onTap() {
    // this has changed
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            screens[_selectedIndex])); // this has changed
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      selectedFontSize: 0,
      selectedItemColor: const Color(0xff4754F0),
      currentIndex: _selectedIndex,
      onTap: (index) {
        // this has changed
        setState(() {
          _selectedIndex = index;
        });
        _onTap();
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xffBAB9D0),
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              color: Color(0xffBAB9D0),
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color(0xffBAB9D0),
            ),
            label: ""),
      ],
    );
  }
}
