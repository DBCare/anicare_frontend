import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/customWidgets/custom_up_information_bar.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/functions/auth.dart';
import 'package:untitled/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/models/user.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:untitled/pages/main_menu.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();

  UserProfile? currUser = Auth.userProfile;

  Widget addFav(Product foundProduct) {
    bool _isFavorite = false;
    Color color;
    if (currUser != null) {
      color = const Color(0xFF4754F0);
    } else {
      color = Colors.grey.shade400;
    }

    String message = "";

    if (currUser != null && currUser!.isFavoriteProduct(foundProduct)) {
      _isFavorite = true;
    }

    return FavoriteButton(
        iconColor: color,
        isFavorite: _isFavorite,
        valueChanged: (_isFavorite) {
          if (currUser == null) {
            message = "You should login to use this feauture.";
          } else {
            if (_isFavorite) {
              currUser!.addFavoriteProduct(foundProduct);
              message = foundProduct.name.toString().toCapitalized() +
                  " is added to the favorite products.";
            } else {
              if (currUser!.removeFavoriteProduct(foundProduct)) {
                message = foundProduct.name.toString().toCapitalized() +
                    " is removed from the favorite products.";
              }
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        });
  }

  Widget certificateBox(
      Product foundProduct, double height, String img, bool cond) {
    return SizedBox(
      height: height * 0.0625,
      width: height * 0.0625,
      child: Opacity(
        opacity: cond ? 1 : 0.0,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                img,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget tagContainers(String tag, Color color) {
    return Container(
      child: Center(
        child: Text(tag,
            style: TextStyle(
              color: color,
              fontSize: 12,
            )),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        color: color.withOpacity(0.2),
      ),
      width: 105,
      height: 38,
    );
  }

  Widget getListItems(List<String> list) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (var item in list)
                  Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Container(
                        child: Center(
                          child: Text(item.toCapitalized(),
                              style: const TextStyle(
                                color: Color(0xFFE64A45),
                                fontSize: 12,
                              )),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: const Color(0xFFE64A45).withOpacity(0.2),
                        ),
                        width: 105,
                        height: 38,
                      ))
              ],
            )),
      ],
    );
  }

  Future<Product?> _createProduct(id, db) async {
    try {
      return await createProduct(id, db);
    } catch (exception) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainMenu(),
          ));
      Auth.showMsg('Product Not Found', "Couldn't Find Product", context);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    return FutureBuilder(
      future: _createProduct(productId, database),
      builder: (BuildContext context, AsyncSnapshot<Product?> snapshot) {
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
                  appBar: CustomUpInformationBar(
                    pageContext: context,
                    title: foundProduct.name,
                    color: Color(0xffF9F9F9),
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
                                      certificateBox(
                                          foundProduct,
                                          height,
                                          'assets/certificate_1.png',
                                          foundProduct.brand.cerPeta),
                                      certificateBox(
                                          foundProduct,
                                          height,
                                          'assets/certificate_2.png',
                                          foundProduct.brand.cerLB),
                                      certificateBox(
                                          foundProduct,
                                          height,
                                          'assets/certificate_3.png',
                                          foundProduct.brand.cerCCF),
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
                                      tagContainers("Cruelty-Free",
                                          const Color(0xFF4754F0)),
                                    if (!foundProduct.brand.crueltyFree)
                                      tagContainers("Not Cruelty-Free",
                                          const Color(0xFFE64A45)),
                                    if (foundProduct.vegan)
                                      tagContainers(
                                          "Vegan", const Color(0xFF4754F0))
                                  ],
                                ),
                                SizedBox(
                                  child: addFav(foundProduct),
                                ),
                              ],
                            ),
                          ),
                          if (foundProduct.ingredientAnalyze.length > 3)
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: getListItems(
                                      foundProduct.ingredientAnalyze)),
                            ),
                          if (foundProduct.ingredientAnalyze.length <= 3)
                            getListItems(foundProduct.ingredientAnalyze),
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
                                      arguments: foundProduct.brand.id);
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
