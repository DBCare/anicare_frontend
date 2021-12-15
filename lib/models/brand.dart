import 'dart:collection';
import 'package:untitled/models/company.dart';

class Brand {
  late Company company;
  late String id;
  late String name;
  late String category;
  late String barcodePrefix;
  late bool cerPeta;
  late bool cerLB;
  late bool cerCCF;
  late bool statusES;
  late bool statusLH;
  late bool statusCFK;
  late bool statusEE;
  late bool statusChina;
  late bool crueltyFree;
  late bool vegan;
  late String picURL;

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
      this.vegan,
      this.picURL);

  Brand.fromMap(LinkedHashMap infoMap, Company comp) {
    company = comp;
    id = infoMap['id'];
    name = infoMap['name'];
    category = infoMap['category'];
    barcodePrefix = infoMap['barcode_prefix'];
    cerPeta = (infoMap['cer_peta'] == '1');
    cerLB = (infoMap['cer_lb'] == '1');
    cerCCF = (infoMap['cer_ccf'] == '1');
    statusES = (infoMap['status_es'] == '1');
    statusLH = (infoMap['status_lh'] == '1');
    statusCFK = (infoMap['status_cfk'] == '1');
    statusEE = (infoMap['status_ee'] == '1');
    statusChina = (infoMap['status_china'] == '1');
    crueltyFree = (infoMap['cruelty_free'] == '1');
    vegan = (infoMap['vegan'] == '1');
    picURL = infoMap['pic-url'];
  }
}
