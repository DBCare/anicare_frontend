import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/custom_up_information_bar.dart';
import 'package:untitled/customWidgets/product_listing.dart';
import 'package:untitled/models/main_data_interface.dart';

class Favorites extends StatefulWidget {
  late List<MainData> itemList;
  late String route;
  Favorites({Key? key, required this.itemList, required this.route})
      : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState(itemList, route);
}

class _FavoritesState extends State<Favorites> {
  late List<MainData> itemList;
  late String route;
  _FavoritesState(this.itemList, this.route);
  //istersen bool yolla istersen iki listi de yolla null olmayanı kullanırız i
  //direkt list yollasak istediğimiz bi
  //gerçi olur çünkü product listing generic olmuştu aynen tmmdır
  //aklıma bi şey daha geldi bi de interface tarzı bi şey ekleyelim tam oop olsun burası bi sn dslaşhkasld

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> list =
        List.generate(itemList.length, (index) => itemList[index].toJson());
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: CustomUpInformationBar(
        pageContext: context,
        title: 'Favorites',
        color: Color(0xffF9F9F9),
      ),
      body: Column(children: [
        ProductListing(
          items: list,
          boldLength: 0,
          route: route,
        )
      ]),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
