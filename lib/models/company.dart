import 'dart:collection';

import 'main_data_interface.dart';

class Company implements MainData {
  late String id;
  late String name;
  late String countryCode;

  Company(this.id, this.name, this.countryCode);

  Company.fromMap(LinkedHashMap infoMap) {
    id = infoMap['id'];
    name = infoMap['name'];
    countryCode = infoMap['country_code'];
  }

  @override
  Map<String, dynamic> toJson() => {
        'company': {'id': id, 'name': name, 'country_code': countryCode}
      };
}
