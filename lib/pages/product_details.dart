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

class ProductDetails extends StatefulWidget {
  final productID;
  const ProductDetails({Key? key, @required this.productID}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(productID);
}

class _ProductDetailsState extends State<ProductDetails> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();
  late String productId;

  _ProductDetailsState(this.productId);
  Future<Product> _createProduct(id, db) async {
    try {} on ItemNotFound {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return ProductDetails(productID: id);
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
      future: _createProduct(productId, database),
      builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
        Size size = MediaQuery.of(context).size;
        final height = MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Product foundProduct = snapshot.data!;
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
                        title: Center(
                            child: Text(foundProduct.name,
                                style: const TextStyle(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: height * 0.5,
                                width: size.width * 4 / 5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(foundProduct.picURL)),
                                ),
                              ),
                              SizedBox(
                                  width: size.width * 1 / 5,
                                  height: height * 0.25,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: height * 0.0625,
                                        width: height * 0.0625,
                                        child: Opacity(
                                          opacity: foundProduct.brand.cerPeta
                                              ? 1
                                              : 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/certificate_1.png',
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.0625,
                                        width: height * 0.0625,
                                        child: Opacity(
                                          opacity: foundProduct.brand.cerLB
                                              ? 1
                                              : 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/certificate_2.png',
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.0625,
                                        width: height * 0.0625,
                                        child: Opacity(
                                          opacity: foundProduct.brand.cerCCF
                                              ? 1
                                              : 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/certificate_3.png',
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    if (foundProduct.brand.crueltyFree)
                                      Container(
                                        child: const Center(
                                          child: Text("Cruelty-Free",
                                              style: TextStyle(
                                                color: Color(0xFF4754F0),
                                                fontSize: 12,
                                              )),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(21),
                                          color: const Color(0xFF4754F0)
                                              .withOpacity(0.2),
                                        ),
                                        width: 105,
                                        height: 38,
                                      ),
                                    if (!foundProduct.brand.crueltyFree)
                                      Container(
                                        child: const Center(
                                          child: Text("Not Cruelty-Free",
                                              style: TextStyle(
                                                color: Color(0xFFE64A45),
                                                fontSize: 12,
                                              )),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(21),
                                          color: const Color(0xFFE64A45)
                                              .withOpacity(0.2),
                                        ),
                                        width: 105,
                                        height: 38,
                                      ),
                                    if (foundProduct.vegan)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Container(
                                          child: const Center(
                                            child: Text("Vegan",
                                                style: TextStyle(
                                                  color: Color(0xFF4754F0),
                                                  fontSize: 12,
                                                )),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                            color: const Color(0xFF4754F0)
                                                .withOpacity(0.2),
                                          ),
                                          width: 105,
                                          height: 38,
                                        ),
                                      ),
                                  ],
                                ),
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
                          if (foundProduct.ingredientAnalyze.length > 3)
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
                                                  i <
                                                      foundProduct
                                                          .ingredientAnalyze
                                                          .length;
                                                  i++)
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4.0),
                                                    child: Container(
                                                      child: Center(
                                                        child: Text(
                                                            foundProduct
                                                                .ingredientAnalyze[
                                                                    i]
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
                                                            BorderRadius
                                                                .circular(21),
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
                          if (foundProduct.ingredientAnalyze.length <= 3)
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          for (int i = 0;
                                              i <
                                                  foundProduct
                                                      .ingredientAnalyze.length;
                                              i++)
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                        foundProduct
                                                            .ingredientAnalyze[
                                                                i]
                                                            .toString()
                                                            .toCapitalized(),
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFFE64A45),
                                                          fontSize: 12,
                                                        )),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            21),
                                                    color:
                                                        const Color(0xFFE64A45)
                                                            .withOpacity(0.2),
                                                  ),
                                                  width: 105,
                                                  height: 38,
                                                ))
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 25.0, right: 25.0),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(foundProduct.name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(foundProduct.description,
                                      style: const TextStyle(
                                          color: Color(0xffBAB9D0),
                                          fontSize: 13.5)),
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
                            child: Text(foundProduct.ingredients,
                                style: const TextStyle(
                                    color: Color(0xffBAB9D0), fontSize: 13)),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/brand_details',
                                      arguments: foundProduct.brand);
                                },
                                child: const Text(
                                  "View Brand Details",
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
