import 'package:flutter/material.dart';


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
        title: Text("Search Product"),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  final products = [
    "Ekmek",
    "Süt",
    "Yumurta",
    "Patlıcan Kebabı",
    "Domates",
    "Beyti",
    "Reçel",
    "Tahin",
    "Adana",
    "Urfa",
  ];

  final suggestedProducts = [
    "Patlıcan Kebabı",
    "Beyti",
    "Adana",
    "Urfa",
  ];
  String searchResult = "";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = "";
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context,"");
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        )
    );
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
        )
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ?suggestedProducts
        :products.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index) => ListTile(
        onTap: (){
          searchResult = suggestionList[index];
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(text: TextSpan(
          text: suggestionList[index].substring(0,query.length),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [TextSpan(
            text : suggestionList[index].substring(query.length),
            style: TextStyle(color: Colors.grey),
          )]
        )
        ),
    ),
      itemCount: suggestionList.length,
    );
  }

}
