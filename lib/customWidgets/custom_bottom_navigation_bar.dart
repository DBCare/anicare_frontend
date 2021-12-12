import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return BottomNavigationBar(
      iconSize: 30,
      selectedFontSize: 0,
      selectedItemColor: Color(0xff4754F0),
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      items:[
        BottomNavigationBarItem(icon: Icon(Icons.home,color: Color(0xffBAB9D0),), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded,color: Color(0xffBAB9D0),), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person,color: Color(0xffBAB9D0),), label: ""),
      ],
    );
  }
}
