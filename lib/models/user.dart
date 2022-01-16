import 'dart:collection';
import 'dart:convert';
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
    List<String> res = List.empty();
    for (var brand in brands) {
      res.add(brand.id);
    }

    return res;
  }

  List<String> getProductID(List<Product> products) {
    List<String> res = List.empty();
    for (var pr in products) {
      res.add(pr.id);
    }

    return res;
  }

  toJson() => {
        uid: {
          'name': name,
          'email': email,
          'imgURL': imgURL,
          'allergies': jsonEncode(allergies),
          'favBrands': jsonEncode(getBrandID(favBrands)),
          'favProducts': jsonEncode(getProductID(favProducts)),
        }
      };

  UserProfile.fromMap(
      LinkedHashMap infoMap, this.uid, this.favBrands, this.favProducts) {
    name = infoMap['name'];
    email = infoMap['email'];
    imgURL = infoMap['imgURL'];
    allergies = jsonDecode(infoMap['allergies']);
  }
}
