import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Product"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  String searchResult = "";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Card(
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: SizedBox(
            width: 300,
            height: 200,
            child: Center(child: Text(searchResult)),
          )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    final database = FirebaseDatabase.instance.reference();

    return FutureBuilder(
        future: searchSuggestion(query, database),
        builder: (BuildContext context,
            AsyncSnapshot<List<Pair<String, String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Pair<String, String>> items = snapshot.data!;
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    searchResult = items[index].last;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            productID: searchResult,
                          ),
                        ));
                  },
                  leading: const Icon(Icons.location_city),
                  title: RichText(
                      text: TextSpan(
                          text: items[index].first.substring(0, query.length),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: items[index].first.substring(query.length),
                          style: const TextStyle(color: Colors.grey),
                        )
                      ])),
                ),
                itemCount: items.length,
              );
            }
          }
          return const Center(child: Text('error'));
        });
  }
}
