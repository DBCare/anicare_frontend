import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/brand.dart';
import 'package:untitled/models/company.dart';
import 'package:untitled/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductDetails extends StatefulWidget {
  final product_id;
  const ProductDetails({Key? key, @required this.product_id}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(product_id);
}

class _ProductDetailsState extends State<ProductDetails> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();
  late String productId;

  _ProductDetailsState(this.productId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: createProduct(productId, database),
        builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Product mainProduct = snapshot.data!;
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Color(0xFFF7F48B),
                  appBar: AppBar(
                    title: Text(mainProduct.name,
                        style: TextStyle(
                          fontSize: 20.0,
                        )),
                    centerTitle: true,
                    backgroundColor: Color(0xFFF47C7C),
                    leading: const Icon(Icons.arrow_back),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.menu),
                      )
                    ],
                  ),
                  body: Column(
                    children: [
                      Container(
                        height: 200.0,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        decoration: BoxDecoration(
                          color: Color(0x33F6748B),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*Padding(
                          padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          child: Container(
                              child: Image.asset(mainProduct.imageUrl,
                                  width: 200.0, height: 200.0)),
                        ),*/
                            Container(
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    mainProduct.brand.cerPeta == true
                                        ? Container(
                                            child: Opacity(
                                                opacity: 1.0,
                                                child: Image.asset(
                                                    'assets/certificate_1.png',
                                                    width: 45.0,
                                                    height: 45.0)),
                                          )
                                        : Container(
                                            child: Opacity(
                                                opacity: 0.3,
                                                child: Image.asset(
                                                    'assets/certificate_1.png',
                                                    width: 45.0,
                                                    height: 45.0)),
                                          ),
                                    mainProduct.brand.cerLB == true
                                        ? Container(
                                            child: Opacity(
                                                opacity: 1.0,
                                                child: Image.asset(
                                                    'assets/certificate_2.png',
                                                    width: 45.0,
                                                    height: 45.0)),
                                          )
                                        : Container(
                                            child: Opacity(
                                                opacity: 0.3,
                                                child: Image.asset(
                                                    'assets/certificate_2.png',
                                                    width: 45.0,
                                                    height: 45.0)),
                                          ),
                                    mainProduct.brand.cerCCF == true
                                        ? Container(
                                            child: Opacity(
                                                opacity: 1.0,
                                                child: Image.asset(
                                                    'assets/certificate_3.png',
                                                    width: 45.0,
                                                    height: 45.0)),
                                          )
                                        : Container(
                                            child: Opacity(
                                                opacity: 0.3,
                                                child: Image.asset(
                                                    'assets/certificate_3.png',
                                                    width: 45.0,
                                                    height: 45.0)),
                                          )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F48B),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 65.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                /*color: mainProduct.allergy == true
                                ? Color(0xFFD92027)
                                : Color(0xFFA1DE93),*/
                                color: Color(0xFFD92027),
                                borderRadius: BorderRadius.circular(30.0),
                                border:
                                    Border.all(color: Colors.white60, width: 3),
                              ),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 15.0),
                                    child: Icon(Icons.health_and_safety,
                                        size: 20.0),
                                  ),
                                  /*mainProduct.allergy == true
                                  ? Text(
                                      "This product contains allergic substance.",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))
                                  : Text(
                                      "This product does not contain allergic substance.",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),*/
                                  Text(
                                      "This product does not contain allergic substance.",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))
                                ],
                              ),
                            ),
                            Container(
                              height: 65.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                color: mainProduct.brand.crueltyFree == true
                                    ? Color(0xFFA1DE93)
                                    : Color(0xFFD92027),
                                borderRadius: BorderRadius.circular(30.0),
                                border:
                                    Border.all(color: Colors.white60, width: 3),
                              ),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 15.0),
                                    child: Icon(Icons.pets, size: 20.0),
                                  ),
                                  mainProduct.brand.crueltyFree == true
                                      ? Text(
                                          "This product has not been tested on animals.",
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))
                                      : Text(
                                          "This product has been tested on animals.",
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                ],
                              ),
                            ),
                            Container(
                              height: 65.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 30.0),
                              decoration: BoxDecoration(
                                color: mainProduct.vegan == true
                                    ? Color(0xFFA1DE93)
                                    : Color(0xFFD92027),
                                borderRadius: BorderRadius.circular(30.0),
                                border:
                                    Border.all(color: Colors.white60, width: 3),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 15.0),
                                    child: Icon(Icons.no_food, size: 20.0),
                                  ),
                                  mainProduct.vegan == true
                                      ? Text("Vegans can use this product.",
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))
                                      : Text(
                                          "Vegans should not use this product.",
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          //margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                          //color: Colors.black,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF70A1D7),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                                child: Center(
                                    child: Text('INGREDIENTS',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1.5))),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 5.0, 5.0),
                                child: Text(mainProduct.ingredients,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        letterSpacing: 1.1)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Text('error');
        });
  }
}
