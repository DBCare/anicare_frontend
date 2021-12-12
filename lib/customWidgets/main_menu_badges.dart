import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuBadges extends StatelessWidget {
  String filePath;
  String text;
  MainMenuBadges({required this.filePath,required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0),
      minWidth: 0,
      onPressed: () { print("AAA"); },
      child: Column(
        children: [
          Image(image: new AssetImage(filePath)),
          Text(text,style: TextStyle(fontSize: 13,color: Colors.black))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
