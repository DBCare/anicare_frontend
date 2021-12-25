import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/custom_drawer.dart';
import 'package:untitled/customWidgets/search_bar.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'product_details.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String query = '';
  String searchResult = "";

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
        appBar: PreferredSize(
          preferredSize: Size(size.width, height * 0.1),
          child: Center(
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: const Color(0xFF29303E),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              backgroundColor: const Color(0xffF9F9F9),
              title: const Center(
                  child: Text("Search Results",
                      style:
                          TextStyle(color: Color(0xFF29303E), fontSize: 14))),
              elevation: 0,
            ),
          ),
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
                      List<Map<String, dynamic>> items = snapshot.data!;
                      return Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                width: double.infinity,
                                height: 70,
                                child: Center(
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    onTap: () {
                                      searchResult = items[index]['id'];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              productID: searchResult,
                                            ),
                                          ));
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(items[index]['pic-url']),
                                      backgroundColor: Colors.white,
                                    ),
                                    title: RichText(
                                        text: TextSpan(
                                            text: items[index]['name']
                                                .substring(0, query.length),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            children: [
                                          TextSpan(
                                            text: items[index]['name']
                                                .substring(query.length),
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                          )
                                        ])),
                                    subtitle: Text(items[index]['category'],
                                        style: TextStyle(
                                            color: Color(0xff4754F0),
                                            fontSize: 13)),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color(0xffBAB9D0)),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                  ),
                                ),
                              ),
                            ),
                            itemCount: items.length,
                          ),
                        ),
                      );
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
                            backgroundColor: Color(0xff4754F0),
                          ),
                          onPressed: () {},
                          child: const Text("Couldn't find it? Suggest us.",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))),
                    ),
                  );
                }),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        endDrawer: CustomDrawer(),
      ),
    );
  }

  void search(String query) {
    setState(() {
      this.query = query;
    });
  }
}
