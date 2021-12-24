import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
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
                        style: TextStyle(
                            color: Color(0xFF29303E), fontSize: 14))),
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
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                  width: double.infinity,
                  height: height * 0.06,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff4754F0).withOpacity(0.2))),
                            onPressed: () {},
                            child: const Text("Vegan",
                                style: TextStyle(
                                    color: Color(0xff4754F0), fontSize: 12))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff4754F0).withOpacity(0.2))),
                            onPressed: () {},
                            child: const Text("Cruelty-Free",
                                style: TextStyle(
                                    color: Color(0xff4754F0), fontSize: 12))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff4754F0).withOpacity(0.2))),
                            onPressed: () {},
                            child: const Text("PETA",
                                style: TextStyle(
                                    color: Color(0xff4754F0), fontSize: 12))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff4754F0).withOpacity(0.2))),
                            onPressed: () {},
                            child: const Text("CCF",
                                style: TextStyle(
                                    color: Color(0xff4754F0), fontSize: 12))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff4754F0).withOpacity(0.2))),
                            onPressed: () {},
                            child: const Text("Filter1",
                                style: TextStyle(
                                    color: Color(0xff4754F0), fontSize: 12))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21.0),
                                )),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff4754F0).withOpacity(0.2))),
                            onPressed: () {},
                            child: const Text("Filter2",
                                style: TextStyle(
                                    color: Color(0xff4754F0), fontSize: 12))),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              FutureBuilder(
                  future: searchSuggestion(query, database),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Pair<String, String>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<Pair<String, String>> items = snapshot.data!;
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
                                        searchResult = items[index].last;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(
                                                productID: searchResult,
                                              ),
                                            ));
                                      },
                                      leading: const CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/product.png"),
                                        backgroundColor: Colors.white,
                                      ),
                                      title: RichText(
                                          text: TextSpan(
                                              text: items[index]
                                                  .first
                                                  .substring(0, query.length),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                              children: [
                                            TextSpan(
                                              text: items[index]
                                                  .first
                                                  .substring(query.length),
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                            )
                                          ])),
                                      subtitle: const Text("Product short-description", style: TextStyle(color: Color(0xff4754F0),fontSize: 13)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xff4754F0),
                            ),
                            onPressed: () {},
                            child: const Text("Couldn't find it? Suggest us." , style: TextStyle(fontSize: 16,color: Colors.white))
                        ),
                      ),
                    );
                  }),
            ],
          ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }

  void search(String query) {
    setState(() {
      this.query = query;
    });
  }
}
