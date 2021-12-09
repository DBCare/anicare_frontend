import 'dart:collection';

class Company {
  late String id;
  late String name;
  late String countryCode;

  Company(this.id, this.name, this.countryCode);

  Company.fromMap(LinkedHashMap infoMap) {
    id = infoMap['id'];
    name = infoMap['name'];
    countryCode = infoMap['country_code'];
  }
}
