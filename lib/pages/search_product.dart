import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/search_bar.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'product_details.dart';

Map<String, bool> filter = {
  'vegan': false,
  'cruelty_free': false,
  'cer_peta': false,
  'cer_ccf': false,
  'cer_lb': false
};

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

    List<Map<String, dynamic>> applyFilter(List<Map<String, dynamic>> items) {
      List<Map<String, dynamic>> returnVal = [];
      for (Map<String, dynamic> item in items) {
        bool passFilter = true;
        filter.forEach((key, applyFilter) {
          if (applyFilter && item[key] != true) passFilter = false;
        });
        if (passFilter) returnVal.add(item);
      }
      return returnVal;
    }

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
        body: FutureBuilder(
          future: searchSuggestion(query, database),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> items = snapshot.data!;
                List<Map<String, dynamic>> filteredItems = applyFilter(items);
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
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
                                    backgroundColor: filter['vegan']!
                                        ? MaterialStateProperty.all(
                                            (const Color(0xff4754F0)
                                                .withOpacity(1)))
                                        : MaterialStateProperty.all(
                                            const Color(0xff4754F0)
                                                .withOpacity(0.2))),
                                onPressed: () {
                                  filter['vegan'] = !filter['vegan']!;
                                  setState(() {
                                    filteredItems = applyFilter(items);
                                  });
                                },
                                child: Text("Vegan",
                                    style: TextStyle(
                                        color: filter['vegan']!
                                            ? Color(0xFFFFFFFF)
                                            : Color(0xff4754F0),
                                        fontSize: 12))),
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
                                    backgroundColor: filter['cruelty_free']!
                                        ? MaterialStateProperty.all(
                                            (const Color(0xff4754F0)
                                                .withOpacity(1)))
                                        : MaterialStateProperty.all(
                                            const Color(0xff4754F0)
                                                .withOpacity(0.2))),
                                onPressed: () {
                                  filter['cruelty_free'] =
                                      !filter['cruelty_free']!;
                                  setState(() {
                                    filteredItems = applyFilter(items);
                                  });
                                },
                                child: Text("Cruelty-Free",
                                    style: TextStyle(
                                        color: filter['cruelty_free']!
                                            ? Color(0xFFFFFFFF)
                                            : Color(0xff4754F0),
                                        fontSize: 12))),
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
                                    backgroundColor: filter['cer_peta']!
                                        ? MaterialStateProperty.all(
                                            (const Color(0xff4754F0)
                                                .withOpacity(1)))
                                        : MaterialStateProperty.all(
                                            const Color(0xff4754F0)
                                                .withOpacity(0.2))),
                                onPressed: () {
                                  filter['cer_peta'] = !filter['cer_peta']!;
                                  setState(() {
                                    filteredItems = applyFilter(items);
                                  });
                                },
                                child: Text("PETA",
                                    style: TextStyle(
                                        color: filter['cer_peta']!
                                            ? Color(0xFFFFFFFF)
                                            : Color(0xff4754F0),
                                        fontSize: 12))),
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
                                    backgroundColor: filter['cer_ccf']!
                                        ? MaterialStateProperty.all(
                                            (const Color(0xff4754F0)
                                                .withOpacity(1)))
                                        : MaterialStateProperty.all(
                                            const Color(0xff4754F0)
                                                .withOpacity(0.2))),
                                onPressed: () {
                                  filter['cer_ccf'] = !filter['cer_ccf']!;
                                  setState(() {
                                    filteredItems = applyFilter(items);
                                  });
                                },
                                child: Text("CCF",
                                    style: TextStyle(
                                        color: filter['cer_ccf']!
                                            ? Color(0xFFFFFFFF)
                                            : Color(0xff4754F0),
                                        fontSize: 12))),
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
                                    backgroundColor: filter['cer_lb']!
                                        ? MaterialStateProperty.all(
                                            (const Color(0xff4754F0)
                                                .withOpacity(1)))
                                        : MaterialStateProperty.all(
                                            const Color(0xff4754F0)
                                                .withOpacity(0.2))),
                                onPressed: () {
                                  filter['cer_lb'] = !filter['cer_lb']!;

                                  setState(() {
                                    filteredItems = applyFilter(items);
                                  });
                                },
                                child: Text("Leaping Bunny",
                                    style: TextStyle(
                                        color: filter['cer_lb']!
                                            ? Color(0xFFFFFFFF)
                                            : Color(0xff4754F0),
                                        fontSize: 12))),
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
                                        const Color(0xff4754F0)
                                            .withOpacity(0.2))),
                                onPressed: () {},
                                child: const Text("Filter2",
                                    style: TextStyle(
                                        color: Color(0xff4754F0),
                                        fontSize: 12))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  Expanded(
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
                                  searchResult =
                                      filteredItems[index]['id'].toString();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                          productID: searchResult,
                                        ),
                                      ));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      filteredItems[index]['pic-url']
                                          .toString()),
                                  backgroundColor: Colors.white,
                                ),
                                title: RichText(
                                    text: TextSpan(
                                        text: filteredItems[index]['name']
                                            .toString()
                                            .substring(0, query.length),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        children: [
                                      TextSpan(
                                        text: filteredItems[index]['name']
                                            .toString()
                                            .substring(query.length),
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      )
                                    ])),
                                subtitle: Text(
                                    filteredItems[index]['description']
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xff4754F0),
                                        fontSize: 13)),
                                trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xffBAB9D0)),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                              ),
                            ),
                          ),
                        ),
                        itemCount: filteredItems.length,
                      ),
                    ),
                  )
                ]);
              }
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff4754F0),
                    ),
                    onPressed: () {},
                    child: const Text("Couldn't find it? Suggest us.",
                        style: TextStyle(fontSize: 16, color: Colors.white))),
              ),
            );
          },
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
