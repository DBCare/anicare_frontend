import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/custom_exception.dart';
import 'package:untitled/functions/auth.dart';
import 'package:untitled/models/brand.dart';
import 'package:untitled/models/company.dart';
import 'package:untitled/models/product.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/request.dart';
import 'package:untitled/models/user.dart';

const String brandPath = 'brands/';
const String categoryPath = 'categories/';
const String requestPath = 'requests/';
const String userPath = 'users/';

Future<List<Map<String, dynamic>>> searchSuggestion(
    String begin, DatabaseReference db) async {
  final productRef = db.child('products');
  final brandRef = db.child('brands');
  List<Map<String, dynamic>> itemMapList = [];
  begin.toLowerCase();

  await productRef
      .orderByChild('name')
      .startAt(begin.toUpperCase())
      .endAt(begin.toLowerCase() + "\uf8ff")
      .once()
      .then((value) {
    if (value.value != null) {
      LinkedHashMap arr = value.value;
      arr.forEach((key, value) async {
        Map<String, dynamic> item = {};
        item['name'] = value['name'];
        item['id'] = value['id'];
        item['brand_id'] = value['brand_id'];
        item['description'] = value['description'].substring(0, 20);
        item['pic-url'] = value['pic-url'];

        itemMapList.add(item);
      });
    }
  });
  for (int i = 0; i < itemMapList.length; ++i) {
    await db.child('brands/' + itemMapList[i]['brand_id']).once().then((value) {
      LinkedHashMap arr = value.value;
      itemMapList[i]['brand_name'] = arr['name'];
      itemMapList[i]['vegan'] = arr['vegan'] == '1';
      itemMapList[i]['category'] = arr['category'];
      itemMapList[i]['cer_peta'] = arr['cer_peta'] == '1';
      itemMapList[i]['cer_lb'] = arr['cer_lb'] == '1';
      itemMapList[i]['cer_ccf'] = arr['cer_ccf'] == '1';
      itemMapList[i]['cruelty_free'] = arr['cruelty_free'] == '1';
    });
  }
  ;
  return itemMapList;
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
  List<String> analyze = [];
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
    for (var item in value) {
      analyze.add(item.toString());
    }
  });

  debugPrint("PRODUCT INFO:");
  debugPrint(prodInfo);
  Brand brand = Brand(Company('', '', ''), '', '', '', '', false, false, false,
      false, false, false, false, false, false, false, '');
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

  if (Auth.userProfile != null) {
    for (var item in Auth.userProfile!.allergies) {
      if (ingr.toLowerCase().contains(item.toString().toLowerCase())) {
        ingredientStatus.add(item.toString());
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

String pushCompany(Company comp, String path) {
  final db = FirebaseDatabase.instance.reference();
  DatabaseReference ref = db.child(path);
  DatabaseReference push = ref.push();
  String pushId = push.key;

  push.set(comp.toJson());
  return pushId;
}

String pushBrand(Brand brand, String path) {
  String pushId = pushCompany(brand.company, path);
  return pushId;
}

String pushProduct(Product prod, String path) {
  String pushId = pushBrand(prod.brand, path);
  return pushId;
}

String pushUser(UserProfile userProfile) {
  final db = FirebaseDatabase.instance.reference();
  DatabaseReference ref = db.child('users');
  String pushId = ref.key;

  ref.update(userProfile.toJson());
  return pushId;
}

Future<UserProfile?> getUser(String uid) async {
  final db = FirebaseDatabase.instance.reference();
  String path = 'users/' + uid;
  final DatabaseReference ref = db.child(path);

  List<Brand> favBrands = [];
  List<Product> favProducts = [];
  List? br = [];
  List? pr = [];
  LinkedHashMap map = LinkedHashMap();
  DataSnapshot snapshot = await ref.once();
  if (snapshot.value == null) return null;

  await ref.once().then((value) {
    map = value.value;
    debugPrint("User Info: " + map.toString());
    br = map['favBrands'];
    pr = map['favProducts'];
  });

  if (pr != null) {
    for (var i = 0; i < pr!.length; i++) {
      await createProduct(pr![i].toString(), db)
          .then((value) => favProducts.add(value));
    }
  }

  if (br != null) {
    for (var i = 0; i < br!.length; i++) {
      await createBrand(br![i].toString(), db)
          .then((value) => favBrands.add(value));
    }
  }

  return UserProfile.fromMap(map, uid, favBrands, favProducts);
}

Future<List> getBrands() async {
  final db = FirebaseDatabase.instance.reference();
  DatabaseReference ref = db.child(brandPath);
  List<String> brands = [];

  await ref.once().then((value) {
    if (value.value != null) {
      LinkedHashMap arr = value.value;
      arr.forEach((key, value) {
        brands.add(value['name']);
      });
    }
  });

  return brands;
}

Future<List> getCategories() async {
  final db = FirebaseDatabase.instance.reference();
  DatabaseReference ref = db.child(categoryPath);
  List<String> categories = [];

  await ref.once().then((value) {
    if (value.value != null) {
      LinkedHashMap arr = value.value;
      arr.forEach((key, value) {
        categories.add(key);
      });
    }
  });

  return categories;
}

String addRequest(Request req) {
  final db = FirebaseDatabase.instance.reference();
  DatabaseReference ref = db.child(requestPath);
  DatabaseReference push = ref.push();

  String pushKey = push.key;
  Map<String, dynamic> reqJSON = req.toJson();
  reqJSON['id'] = pushKey;

  push.set(reqJSON);
  return pushKey;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
