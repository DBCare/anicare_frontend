import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/custom_up_information_bar.dart';
import 'package:untitled/customWidgets/product_listing.dart';
import 'package:untitled/functions/auth.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Map<String, dynamic>> list = List.generate(
      Auth.userProfile!.favProducts.length,
      (index) => Auth.userProfile!.favProducts[index].toJson());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: CustomUpInformationBar(
        pageContext: context,
        title: 'Favorites',
      ),
      body: Column(children: [ProductListing(items: list, boldLength: 0)]),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
