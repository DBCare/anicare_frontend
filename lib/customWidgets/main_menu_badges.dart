import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/filter.dart';
import 'package:untitled/pages/search_product.dart';

class MainMenuBadges extends StatelessWidget {
  String filePath;
  String text;
  bool crueltyFreeFilter, veganFilter, allergyFreeFilter;
  BuildContext mainContext;
  MainMenuBadges(
      {required this.mainContext,
      required this.filePath,
      required this.text,
      required this.crueltyFreeFilter,
      required this.veganFilter,
      required this.allergyFreeFilter});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getBrands(), getCategories()]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return MaterialButton(
                padding: const EdgeInsets.all(0),
                minWidth: 0,
                onPressed: () {
                  Navigator.push(
                      mainContext,
                      MaterialPageRoute(
                        builder: (context) => SearchProduct(
                          filter: Filter(
                              snapshot.data![0],
                              snapshot.data![1],
                              crueltyFreeFilter,
                              veganFilter,
                              allergyFreeFilter),
                        ),
                      ));
                },
                child: Column(
                  children: [
                    Image(image: AssetImage(filePath)),
                    Text(text,
                        style: const TextStyle(fontSize: 13, color: Colors.black))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              );
            }
          }
          return MaterialButton(
            padding: const EdgeInsets.all(0),
            minWidth: 0,
            onPressed: () {},
            child: Column(
              children: [
                Image(image: AssetImage(filePath)),
                Text(text, style: const TextStyle(fontSize: 13, color: Colors.black))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }
}
