import 'package:flutter/material.dart';

class BarcodeResults extends StatefulWidget {
  const BarcodeResults({Key? key}) : super(key: key);

  @override
  State<BarcodeResults> createState() => _BarcodeResultsState();
}

class _BarcodeResultsState extends State<BarcodeResults> {
  String barcodeRes = "Couldn't read.";
  @override
  Widget build(BuildContext context) {
    barcodeRes = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Scan Result',
            style: TextStyle(
              fontSize: 20.0,

            )
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[500],
      ),
      body: Row(
        children: <Widget>[
          Center(
              child: Text(
                  'Scan Result: $barcodeRes',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.amber,

                ),
              )
          )
        ],
      ),
    );
  }
}
