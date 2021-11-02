import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/brand.dart';
import 'dart:convert';

class Product {
  late Brand brand;
  late bool vegan;
  late String name;
  late String category;
  late String subCategory;
  late String description;
  late String barcode;
  late String ingredientStatus;
  late String ingredients;

  Product(
      this.brand,
      this.vegan,
      this.name,
      this.category,
      this.subCategory,
      this.description,
      this.barcode,
      this.ingredientStatus,
      this.ingredients) {/*INTENTIONALLY EMPTY*/}

  Product.fromMap(LinkedHashMap infoMap, Brand br) {
    debugPrint(infoMap.toString());
    brand = br;
    vegan = (infoMap['status_vegan'] == '1');
    name = infoMap['name'];
    category = infoMap['category'];
    subCategory = infoMap['sub_category'];
    description = infoMap['description'];
    barcode = infoMap['barcode'];
    ingredientStatus = infoMap['status_ingredient'];
    ingredients = infoMap['ingredients'];
  }
}

/*

Class Product{
  int id;
  Brand brand;
  String name;
  String category;
  String subCategory;
  String ingredients;
  String description;
  String ingredientStatus; //gluten_free, sulfate_free etc.
  String barcode;
  bool vegan;
}

*/