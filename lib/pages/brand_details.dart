import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/brand.dart';
import 'package:untitled/models/company.dart';
import 'package:untitled/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';

class BrandDetails extends StatefulWidget {
  final product_id;
  const BrandDetails({Key? key, @required this.product_id}) : super(key: key);

  @override
  _BrandDetailsState createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails> {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //final database = FirebaseDatabase.instance.reference();
  //late String productId;

  //_ProductDetailsState(this.productId);

  @override
  Widget build(BuildContext context) {
    final brand = ModalRoute.of(context)!.settings.arguments as Brand;
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFFE5E5E5),
          appBar: PreferredSize(
            preferredSize: Size(size.width, height * 0.1),
            child: Center(
              child: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.arrow_back_ios, color: Color(0xFF29303E)),
                ),
                backgroundColor: Color(0xFFFFFFFF),
                title: Center(
                    child: Text(brand.name,
                        style: TextStyle(color: Color(0xFF29303E)))),
                elevation: 0,
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.25,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage(
                        'assets/Faith-In-Nature-Category.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: height * 0.54,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Center(
                                  child: Text("Cruelty-Free",
                                      style: TextStyle(
                                        color: Color(0xFF4754F0),
                                        fontSize: 12,
                                      )),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(21),
                                  color: Color(0xFF4754F0).withOpacity(0.2),
                                ),
                                width: 99,
                                height: 36,
                              ),
                              Container(
                                child: Icon(Icons.favorite,
                                    color: Color(0xFFC2C2FE).withOpacity(1)),
                                height: 24,
                                width: 26,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 25.0, right: 25.0),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(brand.name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  brand.crueltyFree
                                      ? Text(
                                          "Faith in Nature has confirmed that it is truly cruelty-free.",
                                          style: TextStyle(
                                              color: Color(0xff4754F0),
                                              fontSize: 14))
                                      : Text(
                                          "Faith in Nature has NOT confirmed that it is truly cruelty-free.",
                                          style: TextStyle(
                                              color: Color(0xff4754F0),
                                              fontSize:
                                                  14)), //NAME kısmına firma adı yazılacak. (true == true yerine cruelty_free == true olacak)
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                    "They don't test finished products or ingredients on animals, and neither do their suppliers or any third-parties. They also don't sell their products where animal testing is required by law.",
                                    style: TextStyle(
                                        color: Color(0xffBAB9D0),
                                        fontSize: 13.5)),
                              ),
                              Divider(color: Color(0xffBAB9D0))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        true == true
                                            ? Icon(
                                                Icons.check,
                                                color: Color(0xff4754F0),
                                              )
                                            : Icon(Icons.close,
                                                color: Color(0xff4754F0)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                              "Finished products tested on animals"),
                                        ),
                                      ],
                                    ),
                                    brand.crueltyFree
                                        ? Text("No",
                                            style: TextStyle(
                                                color: Color(0xff4754F0),
                                                fontSize: 13.5))
                                        : Text("Yes",
                                            style: TextStyle(
                                                color: Color(0xff4754F0),
                                                fontSize: 13.5))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        true == true
                                            ? Icon(
                                                Icons.check,
                                                color: Color(0xff4754F0),
                                              )
                                            : Icon(Icons.close,
                                                color: Color(0xff4754F0)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                              "Ingredients tested on animals"),
                                        ),
                                      ],
                                    ),
                                    brand.crueltyFree
                                        ? Text("No",
                                            style: TextStyle(
                                                color: Color(0xff4754F0),
                                                fontSize: 13.5))
                                        : Text("Yes",
                                            style: TextStyle(
                                                color: Color(0xff4754F0),
                                                fontSize: 13.5))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        true == true
                                            ? Icon(
                                                Icons.check,
                                                color: Color(0xff4754F0),
                                              )
                                            : Icon(Icons.close,
                                                color: Color(0xff4754F0)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text("Sell on Mainland China"),
                                        ),
                                      ],
                                    ),
                                    !brand.statusChina
                                        ? Text("No",
                                            style: TextStyle(
                                                color: Color(0xff4754F0),
                                                fontSize: 13.5))
                                        : Text("Yes",
                                            style: TextStyle(
                                                color: Color(0xff4754F0),
                                                fontSize: 13.5))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar()),
    );
  }
}
