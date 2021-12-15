import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/custom_exception.dart';
import 'package:untitled/models/brand.dart';
import 'package:untitled/models/company.dart';
import 'package:untitled/models/product.dart';
import 'package:flutter/material.dart';

Future<List<Pair<String, String>>> searchSuggestion(
    String begin, DatabaseReference db) async {
  final productRef = db.child('products');
  List<Pair<String, String>> items = [];
  begin.toLowerCase();

  await productRef
      .orderByChild('name')
      .startAt(begin.toUpperCase())
      .endAt(begin.toLowerCase() + "\uf8ff")
      .once()
      .then((value) {
    if (value.value != null) {
      LinkedHashMap arr = value.value;
      arr.forEach((key, value) {
        items.add(Pair(value['name'].toString(), value['id'].toString()));
      });
    }
  });

  return items;
}

Future<String> getElementMap(String path, DatabaseReference db) async {
  DatabaseReference wantedRef = db.child(path);
  String returnVal = '';

  await wantedRef.once().then((value) => returnVal = value.value.toString());

  return returnVal;
}

Future<Company> createComp(String compId, DatabaseReference db) async {
  DatabaseReference compRef = db.child('companies/' + compId);
  String compInfo = '';
  LinkedHashMap map = LinkedHashMap();
  await compRef.once().then((value) => map = value.value);
  return Company.fromMap(map);
}

Future<Brand> createBrand(String brandId, DatabaseReference db) async {
  DatabaseReference brandRef = db.child('brands/' + brandId);

  String brandInfo = '';
  String compId = '';
  LinkedHashMap map = LinkedHashMap();
  await brandRef.once().then((value) {
    brandInfo = value.value.toString();
    map = value.value;
    compId = map['company_id'];
  });

  Company comp = Company('', '', '');
  await createComp(compId, db).then((value) => comp = value);

  return Brand.fromMap(map, comp);
}

Future<Product> createProduct(String productId, DatabaseReference db) async {
  DatabaseReference prodRef = db.child('products/' + productId);
  if (prodRef == null) {
    throw ItemNotFound("No such product found in database! (EXCEPTION)");
  }

  debugPrint(productId);
  String prodInfo = '';
  String brandId = '';
  String ingr = '';
  List<String> ingrList = [];
  List analyze = [];
  LinkedHashMap map = LinkedHashMap();

  await prodRef.once().then((value) {
    prodInfo = value.value.toString();
    map = value.value;
    brandId = map['brand_id'];
    ingr = map['ingredients'];
  });

  ingrList = editIngredientList(ingr);
  ingr = ingrList.join(",");
  debugPrint("Ingr: " + ingr);

  await analyzeIngredients(ingr, db).then((value) {
    analyze = value;
  });

  debugPrint("PRODUCT INFO:");
  debugPrint(prodInfo);
  Brand brand = Brand(Company('', '', ''), '', '', '', '', false, false, false,
      false, false, false, false, false, false, false);
  await createBrand(brandId, db).then((value) => brand = value);

  return Product.fromMap(map, brand, ingrList, analyze, ingr);
}

Future<String> findBarcode(String barcode, DatabaseReference db) async {
  String productID = '';

  final DatabaseReference productRef = db.child('products');
  debugPrint("BARCODE:");
  debugPrint(barcode);

  await productRef
      .orderByChild('barcode')
      .equalTo(barcode)
      .once()
      .then((value) {
    if (value.value != null) {
      LinkedHashMap arr = value.value;
      arr.forEach((key, value) {
        productID = value['id'];
      });
    }
  });

  return productID;
}

Future<Map> getIngredients(DatabaseReference db) async {
  DatabaseReference prodRef = db.child('ingredients');

  LinkedHashMap map = LinkedHashMap();

  await prodRef.once().then((value) {
    map = value.value;
  });

  return map;
}

Future<List> analyzeIngredients(String ingr, DatabaseReference db) async {
  List ingredients = [];
  List categories = [];
  List<String> ingredientStatus = [];

  await getIngredients(db).then((value) {
    ingredients = value.values.toList();
    categories = value.keys.toList();
  });

  for (var i = 0; i < categories.length; i++) {
    for (var j = 0; j < ingredients[i].length; j++) {
      if (ingr
          .toLowerCase()
          .contains(ingredients[i][j].toString().toLowerCase())) {
        ingredientStatus.add(categories[i]);
      }
    }
  }

  Set temp = ingredientStatus.toSet();
  debugPrint("Product contains " + temp.toString());

  return temp.toList();
}

List<String> editIngredientList(String ingredients) {
  List punc = [",", "|"];
  List<String> ingredientList = [];

  for (var i = 0; i < punc.length; i++) {
    if (ingredients.contains(punc[i])) {
      ingredientList.addAll(ingredients.split(punc[i]));
      break;
    }
  }

  return ingredientList;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
