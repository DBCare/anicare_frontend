import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/database_transactions/db_communication.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    Navigator.pushNamed(context, '/barcode', arguments: barcodeScanRes);
  }

  String searchText = "Search a product";
  String scanText = "Scan a barcode";
  String analyzeText = "Analyze Ingredients";
  @override
  Widget build(BuildContext context) {
    final companyRef = database.child('products');

    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        title: const Text('AniCare',
            style: TextStyle(
              fontSize: 20.0,
            )),
        centerTitle: true,
        backgroundColor: Colors.yellow[500],
        leading: const Icon(Icons.pets),
        actions: [
          IconButton(
            onPressed: () async {
              createProduct('-MnRpUpm5T8HuguZplDF', database);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 130,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/search_product');
                },
                icon: const Icon(Icons.search, size: 60),
                label: Text(
                  searchText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: 130,
              child: ElevatedButton.icon(
                onPressed: () => scanBarcodeNormal(),
                icon: const Icon(Icons.qr_code, size: 60),
                label: Text(
                  scanText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: 130,
              child: ElevatedButton.icon(
                /*onPressed: (){
                  setState(() {
                    analyzeText = 'Coming soon';
                  });
                },*/
                onPressed: () => seeProductDetails(),
                icon: const Icon(Icons.camera_enhance, size: 60),
                label: Text(
                  analyzeText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  seeProductDetails() {
    Navigator.pushNamed(context, '/product');
//    Navigator.pushNamed(context, '/barcode',arguments: barcodeScanRes);
  }
}
