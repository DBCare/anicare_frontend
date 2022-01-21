class Request {
  late String category;
  late String brandName;
  late String name;
  late String description;
  late String status;

  Request(
      this.name, this.brandName, this.category, this.description, this.status);

  bool validateRequest() {
    return (category != '' && brandName != '' && name != '' && status != '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'description': description,
        'brand_name': brandName,
        'state': status
      };
}
