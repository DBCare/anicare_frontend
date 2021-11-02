import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:untitled/models/brand.dart';
import 'package:untitled/models/company.dart';
import 'package:untitled/models/product.dart';

Future<List<Pair<String, String>>> searchSuggestion(
    String begin, DatabaseReference db) async {
  final productRef = db.child('products');
  List<Pair<String, String>> items = [];
  begin.toLowerCase();
  debugPrint(begin);

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

  String prodInfo = '';
  String brandId = '';
  LinkedHashMap map = LinkedHashMap();
  await prodRef.once().then((value) {
    prodInfo = value.value.toString();
    map = value.value;
    brandId = map['brand_id'];
  });

  Brand brand = Brand(Company('', '', ''), '', '', '', '', false, false, false,
      false, false, false, false, false, false, false);
  await createBrand(brandId, db).then((value) => brand = value);

  debugPrint(brandId);

  return Product.fromMap(map, brand);
}
