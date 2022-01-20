import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuCards extends StatelessWidget {
  String filePath;
  String text;
  MainMenuCards({required this.filePath,required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      minWidth: 0,
      onPressed: () { },
      child: Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xff4754F0),
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          width: 120,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 15, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(filePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20,top: 10, right: 30),
                child: Text(text,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
