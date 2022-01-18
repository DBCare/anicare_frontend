import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/custom_drawer.dart';
import 'package:untitled/customWidgets/custom_up_information_bar.dart';
import 'package:untitled/customWidgets/product_listing.dart';
import 'package:untitled/customWidgets/search_bar.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled/models/filter.dart';
import 'product_details.dart';

class SearchProduct extends StatefulWidget {
  final filter;
  const SearchProduct({Key? key, required this.filter}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState(filter);
}

class _SearchProductState extends State<SearchProduct> {
  String query = '';
  String searchResult = "";
  late Filter filter;
  _SearchProductState(this.filter);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    final database = FirebaseDatabase.instance.reference();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        appBar: CustomUpInformationBar(
          pageContext: context,
          title: 'Search Suggestions',
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: SearchBar(text: query, onChanged: search),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
            ),
            FutureBuilder(
                future: searchSuggestion(query, database),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Map<String, dynamic>> items =
                          filter.applyFilter(snapshot.data!);
                      return ProductListing(
                          items: items, boldLength: query.length);
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff4754F0),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/request');
                          },
                          child: const Text("Couldn't find it? Suggest us.",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))),
                    ),
                  );
                }),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        endDrawer: CustomDrawer(filter: filter),
      ),
    );
  }

  void search(String query) {
    setState(() {
      this.query = query;
    });
  }
}
