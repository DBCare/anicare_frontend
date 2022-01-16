class Request {
  late String category;
  late String brandName;
  late String name;
  late String description;

  Request(this.name, this.brandName, this.category, this.description);

  bool validateRequest() {
    return (category != '' &&
        brandName != '' &&
        name != '' &&
        description != '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'description': description,
        'brand_name': brandName
      };
}
