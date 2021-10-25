import 'package:flutter/material.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/pages/barcode_results.dart';
void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    //'/': (context) => Loading(),
    '/home': (context) => Home(),
    '/barcode' : (context) => BarcodeResults()
  }
));