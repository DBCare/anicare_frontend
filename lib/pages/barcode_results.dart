import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'product_details.dart';

class BarcodeResults extends StatefulWidget {
  const BarcodeResults({Key? key}) : super(key: key);

  @override
  State<BarcodeResults> createState() => _BarcodeResultsState();
}

class _BarcodeResultsState extends State<BarcodeResults> {
  String barcodeRes = "Couldn't read.";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    barcodeRes = ModalRoute.of(context)!.settings.arguments as String;
    return FutureBuilder(
        future: findBarcode(barcodeRes, database),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Scan Result',
                      style: TextStyle(
                        fontSize: 20.0,
                      )),
                  centerTitle: true,
                  backgroundColor: Colors.yellow[500],
                ),
                body: Row(
                  children: <Widget>[
                    Center(
                        child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productID: snapshot.data!,
                              ),
                            ));
                      },
                      icon: const Icon(Icons.qr_code, size: 60),
                      label: const Text(
                        "scanText",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ))
                  ],
                ),
              );
            }
          }
          return Scaffold(
              appBar: AppBar(
            title: const Text('Scan Result',
                style: TextStyle(
                  fontSize: 20.0,
                )),
            centerTitle: true,
            backgroundColor: Colors.yellow[500],
          ));
        });
  }
}
