import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/brand.dart';

class Product {
  late Brand brand;
  late bool vegan;
  late String name;
  late String category;
  late String subCategory;
  late String description;
  late String barcode;
  late String ingredients;
  late List ingredientList;
  late List ingredientAnalyze;
  late String picURL;

  Product(
      this.brand,
      this.vegan,
      this.name,
      this.category,
      this.subCategory,
      this.description,
      this.barcode,
      this.ingredients,
      this.ingredientList,
      this.picURL) {/*INTENTIONALLY EMPTY*/}

  Product.fromMap(LinkedHashMap infoMap, Brand br, List ingrList, List analyze,
      String ingr) {
    debugPrint(infoMap.toString());
    brand = br;
    vegan = (infoMap['status_vegan'] == '1');
    name = infoMap['name'];
    category = infoMap['category'];
    subCategory = infoMap['sub_category'];
    description = infoMap['description'];
    barcode = infoMap['barcode'];
    picURL = infoMap['pic-url'];
    ingredientList = ingrList;
    ingredientAnalyze = analyze;
    ingredients = ingr;
  }
}
