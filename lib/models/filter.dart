import 'package:analyzer_plugin/utilities/pair.dart';

class Filter {
  late List<Pair<String, bool>> brandFilter;
  late List<Pair<String, bool>> categoryFilter;
  late bool crueltyFreeFilter;
  late bool veganFilter;
  late bool allergyFreeFilter;

  Filter(List<String> brands, List<String> categories, this.crueltyFreeFilter,
      this.veganFilter, this.allergyFreeFilter) {
    brandFilter =
        List.generate(brands.length, (index) => Pair(brands[index], false));
    categoryFilter = List.generate(
        categories.length, (index) => Pair(categories[index], false));
  }

  List<Pair<String, bool>> getBrandFilter() {
    return brandFilter;
  }

  List<Pair<String, bool>> getCategoryFilter() {
    return categoryFilter;
  }

  bool isBrandFilterActive() {
    for (var element in brandFilter) {
      if (element.last) return true;
    }
    return false;
  }

  bool isCategoryFilterActive() {
    for (var element in categoryFilter) {
      if (element.last) return true;
    }
    return false;
  }

  bool getBrandFilterValue(String brandName) {
    for (var element in brandFilter) {
      if (element.first == brandName) {
        return element.last;
      }
    }
    return false;
  }

  bool getCategoryFilterValue(String categoryName) {
    for (var element in categoryFilter) {
      if (element.first == categoryName) {
        return element.last;
      }
    }
    return false;
  }

  void activateCategory(String categoryName) {
    for (int i = 0; i < categoryFilter.length; ++i) {
      if (categoryFilter[i].first == categoryName) {
        categoryFilter[i] = Pair(categoryFilter[i].first, true);
      } else {
        categoryFilter[i] = Pair(categoryFilter[i].first, false);
      }
    }
  }

  List<Map<String, dynamic>> applyFilter(List<Map<String, dynamic>> items) {
    List<Map<String, dynamic>> returnVal = [];

    for (var element in items) {
      if ((!isBrandFilterActive() ||
              getBrandFilterValue(element['brand_name'])) &&
          (!isCategoryFilterActive() ||
              getCategoryFilterValue(element['category']))) {
        if ((!crueltyFreeFilter || element['cruelty_free']) &&
            (!veganFilter || element['vegan'])) {
          returnVal.add(element);
        }
      }
    }
    return returnVal;
  }
}
