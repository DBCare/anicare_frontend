import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/product_listing.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Map<String, dynamic>> list = [];
  Map<String, dynamic> map = {
    'name': 'test',
    'id': "-MnRnjjvcXl7OH_lGlM5",
    'category': 'test',
    'pic-url':
        "https://cdn.shopify.com/s/files/1/0513/8923/5351/products/lavender_Geranium_Conditioner400ml_x2_65f65fed-b22d-4a9d-a5d2-d9f1c45abf8e.png?v=1625831210"
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: Column(children: [
        ProductListing(items: [map], boldLength: 0)
      ]),
    );
  }
}
