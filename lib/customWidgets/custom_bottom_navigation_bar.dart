import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/main_menu.dart';
import 'package:untitled/pages/recognize_text.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final screens = [MainMenu(), RecognizeTextScreen(), MainMenu()];
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
      selectedItemColor: Color(0xff4754F0),
      currentIndex: _selectedIndex,
      onTap: (index) {
        // this has changed
        setState(() {
          _selectedIndex = index;
        });
        _onTap();
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xffBAB9D0),
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner_rounded,
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
