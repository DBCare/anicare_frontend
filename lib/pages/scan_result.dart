import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/database_transactions/custom_exception.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/brand.dart';
import 'package:untitled/models/company.dart';
import 'package:untitled/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/pages/home.dart';

class scanResult extends StatefulWidget {
  final ingredientL;
  const scanResult({Key? key, @required this.ingredientL}) : super(key: key);

  @override
  _scanResultState createState() => _scanResultState(ingredientL);
}

class _scanResultState extends State<scanResult> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();
  late String ingredient;

  _scanResultState(this.ingredient);
  Future<Product> _createProduct(id, db) async {
    try {} on ItemNotFound {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return scanResult(ingredientL: id);
          },
        ),
      );
    }
    return createProduct(id, db);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return FutureBuilder(
      future: analyzeIngredients(ingredient, database),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        Size size = MediaQuery.of(context).size;
        final height = MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final List ingredientList = snapshot.data!;
            return SafeArea(
              child: Scaffold(
                  backgroundColor: const Color(0xFFF9F9F9),
                  appBar: PreferredSize(
                    preferredSize: Size(size.width, height * 0.1),
                    child: Center(
                      child: AppBar(
                        leading: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.arrow_back_ios,
                              color: Color(0xFF29303E)),
                        ),
                        backgroundColor: const Color(0xFFFFFFFF),
                        title: const Center(
                            child: Text("Scan Result",
                                style: TextStyle(
                                    color: Color(0xFF29303E), fontSize: 14))),
                        elevation: 0,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      width: size.width,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Icon(Icons.favorite,
                                      color: const Color(0xFFC2C2FE)
                                          .withOpacity(1)),
                                  height: 24,
                                  width: 26,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0, vertical: 7),
                                        child: Row(
                                          children: <Widget>[
                                            for (int i = 0;
                                                i < ingredientList.length;
                                                i++)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                          ingredientList[i]
                                                              .toString()
                                                              .toCapitalized(),
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFFE64A45),
                                                            fontSize: 12,
                                                          )),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              21),
                                                      color: const Color(
                                                              0xFFE64A45)
                                                          .withOpacity(0.2),
                                                    ),
                                                    width: 105,
                                                    height: 38,
                                                  ))
                                          ],
                                        )),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 25.0, right: 25.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                       Center(
                                        child: Text("Scan Result",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold)),
                                      ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: const [
                                      Text("Ingredients:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4754F0),
                                              fontSize: 14)),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 15),
                            child: Text(ingredient,
                                style: const TextStyle(
                                    color: Color(0xffBAB9D0), fontSize: 13)),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/request');
                                },
                                child: const Text(
                                  "Request a new Product",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Color(0xFF4754F0)),
                                ),
                                style: ButtonStyle(
                                    shadowColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black.withOpacity(0)),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFF9F9F9)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(21.0),
                                            side: const BorderSide(
                                                color: Color(0xFF4754F0)))))),
                          )
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: const CustomBottomNavigationBar()),
            );
          }
        }
        return const Text('error');
      },
    );
  }
}
