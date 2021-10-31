import 'package:untitled/models/company.dart';

class Brand {
  Company company;
  int id;
  String name;
  String category;
  String barcodePrefix;
  bool cerPeta;
  bool cerLB;
  bool cerCCF;
  bool statusES;
  bool statusLH;
  bool statusCFK;
  bool statusEE;
  bool statusChina;
  bool crueltyFree;
  bool vegan;

  Brand(
      this.company,
      this.id,
      this.name,
      this.category,
      this.barcodePrefix,
      this.cerPeta,
      this.cerLB,
      this.cerCCF,
      this.statusES,
      this.statusLH,
      this.statusCFK,
      this.statusEE,
      this.statusChina,
      this.crueltyFree,
      this.vegan);
}
