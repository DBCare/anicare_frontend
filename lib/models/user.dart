import 'dart:collection';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/product.dart';

import 'brand.dart';

class UserProfile {
  late String uid;
  late String name;
  late String email;
  late String? imgURL;
  late List<Brand> favBrands;
  late List<Product> favProducts;
  late List allergies;

  UserProfile(this.uid, this.name, this.email, this.imgURL, this.favBrands,
      this.favProducts, this.allergies);

  List<String> getBrandID(List<Brand> brands) {
    List<String> res = [];
    for (var brand in brands) {
      res.add(brand.id);
    }

    return res;
  }

  List<String> getProductID(List<Product> products) {
    List<String> res = [];
    for (var pr in products) {
      res.add(pr.id);
    }

    return res;
  }

  bool addAllergy(String allergy) {
    for (var item in allergies) {
      if (item.toString().toLowerCase() == allergy.toLowerCase()) {
        return false;
      }
    }
    allergies.add(allergy.toLowerCase());
    pushUser(this);
    return true;
  }

  bool removeAllergy(int index) {
    if (index < allergies.length) {
      allergies.removeAt(index);
      pushUser(this);
      return true;
    }

    return false;
  }

  bool addFavoriteProduct(Product pr) {
    if (isFavoriteProduct(pr)) return false;
    favProducts.add(pr);
    pushUser(this);
    return true;
  }

  bool removeFavoriteProduct(Product pr) {
    for (var i = 0; i < favProducts.length; i++) {
      if (favProducts[i].id == pr.id) {
        favProducts.removeAt(i);
        pushUser(this);
        return true;
      }
    }

    return false;
  }

  bool isFavoriteProduct(Product pr) {
    for (var item in favProducts) {
      if (item.id == pr.id) return true;
    }
    return false;
  }

  toJson() => {
        uid: {
          'name': name,
          'email': email,
          'imgURL': imgURL,
          'allergies': allergies,
          'favBrands': getBrandID(favBrands),
          'favProducts': getProductID(favProducts),
        }
      };

  UserProfile.fromMap(
      LinkedHashMap infoMap, this.uid, this.favBrands, this.favProducts) {
    name = infoMap['name'];
    email = infoMap['email'];
    imgURL = infoMap['imgURL'];
    allergies =
        infoMap['allergies'] == null ? [] : List.of(infoMap['allergies']);
  }
}
