import 'package:untitled/models/brand.dart';

class Product {
  bool allergy;
  bool cruelty_free;
  bool vegan;
  String name;
  String imageUrl;
  bool certificate_1;
  bool certificate_2;
  bool certificate_3;
  String ingredients;

  Product(
      this.allergy,
      this.cruelty_free,
      this.vegan,
      this.name,
      this.imageUrl,
      this.certificate_1,
      this.certificate_2,
      this.certificate_3,
      this.ingredients) {/*INTENTIONALLY EMPTY*/}
}

Product lens = Product(
    true,
    true,
    false,
    'Acuvue Oasys',
    'assets/lens.png',
    true,
    true,
    false,
    'Senofilcon AI5 (Silicone Hydrogel), 38% water'); //Test amacıyla oluşturuldu.
Product product = Product(
    true,
    false,
    false,
    'Head&Shoulders Şampuan',
    'assets/s.png',
    true,
    true,
    false,
    'Targets dandruff root cause for up to 100% flake-free, clinically proven (with regular use).'); //Test amacıyla oluşturuldu.

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