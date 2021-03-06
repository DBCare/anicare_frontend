import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class BarcodeResults extends StatefulWidget {
  const BarcodeResults({Key? key}) : super(key: key);

  @override
  State<BarcodeResults> createState() => _BarcodeResultsState();
}

class _BarcodeResultsState extends State<BarcodeResults> {
  String barcodeRes = "";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();

  Future<String> _findBarcode(barcode, db) async {
    String id = "-1";
    debugPrint("BARCODE RES:");
    debugPrint(barcodeRes);

    await findBarcode(barcode, db).then((String result) {
      id = result;
    });
    Navigator.pushNamed(context, '/product_details', arguments: id);

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final barc = ModalRoute.of(context)!.settings.arguments as String;
    barcodeRes = barc;
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return FutureBuilder(
      future: _findBarcode(barcodeRes, database),
      builder: (context, snapshot) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
