import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/main_menu_badges.dart';
import 'package:untitled/customWidgets/main_menu_cards.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/pages/product_details.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final database = FirebaseDatabase.instance.reference();

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    Navigator.pushNamed(context, '/barcode', arguments: barcodeScanRes);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
          appBar: AppBar(
            backgroundColor: Color(0xff4754F0),
            elevation: 0,
            leading: Icon(Icons.menu_rounded,size: 24),
            actions: [
              Icon(Icons.notifications_rounded)
            ],
          ),
          body: Column(
            children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        height: height*0.38,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(150, 100),bottomLeft: Radius.elliptical(600, 250)),
                            color: Color(0xff4754F0)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("Hello, Sinem",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Color(0xffF9F9F9))),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text("What are you looking for today?",style: TextStyle(fontSize: 14,color: Color(0xffF9F9F9).withOpacity(0.6))),
                                  )
                                ],
                              ),
                            ),
                            Padding(  //SEARCH BAR YUNUS SENDE
                              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffFCFCFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // <-- Radius
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0,right: 10.0),
                                      child: Icon(Icons.search,color: Color(0xff4754F0)),
                                    ),
                                    Text("Vegan eyeshadow palette",style: TextStyle(fontSize: 14,color: Color(0xffBAB9D0)))
                                  ],
                                ),
                                onPressed: () { showSearch(context: context, delegate: DataSearch()); },
                              ),
                            ),
                          ],
                        )
                    ),
                    Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
                        child: Container(
                          height: height * 0.20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffFFFFFF)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MainMenuBadges(filePath: "assets/cf_badge.png", text: "Cruelty-Free"),
                              MainMenuBadges(filePath: "assets/ef_badge.png", text: "Allergy-Free"),
                              MainMenuBadges(filePath: "assets/vegan_badge.png", text: "Vegan")
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 30,bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Categories",style: TextStyle(fontSize: 18,color:  Color(0xff29303E),fontWeight: FontWeight.bold)),
                    TextButton(
                        onPressed: null,
                        child: Row(
                          children: [
                            Text("Browse all",style: TextStyle(fontSize: 14,color:  Color(0xff4754F0),fontWeight: FontWeight.bold)),
                            Icon(Icons.arrow_forward_ios,color: Color(0xff4754F0),size: 14)
                          ],
                        )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  height: height * 0.20,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      MainMenuCards(filePath: "assets/hair-care.png",text: "Hair Care"),
                      MainMenuCards(filePath: "assets/skin-care.png",text: "Skin Care"),
                      MainMenuCards(filePath: "assets/make-up.png",text: "Make Up"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Color(0xffE5E5E5),
                  shape: CircleBorder(),
                  child: InkWell(
                    onTap: (){scanBarcodeNormal();},
                    child: Image.asset("assets/scan_button.png",
                      height: 50,
                      width: 80,
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
            ],
          ),
        bottomNavigationBar: CustomBottomNavigationBar(),
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
          return const Center(child: Text('Loading'));
        });
  }
}

