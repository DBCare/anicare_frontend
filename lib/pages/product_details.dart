import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/brand.dart';
import 'package:untitled/models/company.dart';
import 'package:untitled/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFFF9F9F9),
          appBar: PreferredSize(
            preferredSize: Size(size.width,height * 0.1),
            child: Center(
              child: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Icon(Icons.arrow_back_ios,color: Color(0xFF29303E)),
                ),
                backgroundColor: Color(0xFFFFFFFF),
                title: Center(child: Text("Search Results",style: TextStyle(color: Color(0xFF29303E),fontSize: 14))),
                elevation: 0,
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height * 0.25,
                      width: size.width * 3/4,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage('assets/product.png',),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 1/4,
                      height: height * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.0625,
                            width: height * 0.0625,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                  'assets/certificate_1.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.0625,
                            width: height * 0.0625,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                  'assets/certificate_2.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.0625,
                            width: height * 0.0625 + 15,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                  'assets/certificate_3.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
                              Row(
                                children: [
                                  Container(
                                    child:
                                    Center(
                                      child: Text("Cruelty-Free", style:TextStyle(
                                        color: Color(0xFF4754F0),
                                        fontSize: 12,
                                      )
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: Color(0xFF4754F0).withOpacity(0.2),
                                    ),
                                    width: 99,
                                    height: 36,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Container(
                                      child:
                                      Center(
                                        child: Text("Vegan", style:TextStyle(
                                          color: Color(0xFF4754F0),
                                          fontSize: 12,
                                        )
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        color: Color(0xFF4754F0).withOpacity(0.2),
                                      ),
                                      width: 99,
                                      height: 36,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child:
                                Icon(Icons.favorite,color: Color(0xFFC2C2FE).withOpacity(1)),
                                height: 24,
                                width: 26,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text("ÜRÜN ADI",style:TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15.0),
                                    child: Text("Kısa ürün açıklaması",style:TextStyle(color: Color(0xff4754F0),fontSize: 14)),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text("NYX has confirmed that it is truly cruelty-free. They don't test finished products or ingredients on animals, and neither do their suppliers or any third-parties.",style:TextStyle(color: Color(0xffBAB9D0),fontSize: 13.5)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                        "Ingredients",style: TextStyle(color: Color(0xFF4754F0), fontSize: 14)
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          "AQUA / WATER / EAU, BUTYLENE GLYCOL, GLYCERIN, BUTYROSPERMUM PARKII BUTTER / SHEA BUTTER, DECYL COCOATE, POLYGLYCERYL-3 METHYLGLUCOSE DISTEARATE, CAPRYLYL METHICONE, DICAPRYLYL CARBONATE, DI-C12-13 ALKYL MALATE",style: TextStyle(color: Color(0xffBAB9D0),fontSize: 11)
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/brand_details');
                                      },
                                      child: Text(
                                        "See Brand Details",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xffBAB9D0))
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar()
      ),
    );
  }
}


