import 'package:flutter/material.dart';
import 'package:task/model/products_model.dart';
import 'package:task/network/category_api.dart';
import 'package:task/network/product_api.dart';

class ProductProvider extends ChangeNotifier {

  String? category;
  void updateCategory(String selectedCategory){
    category = selectedCategory;
    notifyListeners();
  }
  Future<List<String>?> getCategories() async {
    CategoryApi categoryApi = CategoryApi();
    List<String>? categories = await categoryApi.data().then((value) {
      updateCategory(value![0]);
      return value;
    });
    return categories;
  }

  Future<List<ProductsModel>?> getProducts() async {
    ProductsApi productsApi = ProductsApi();
    List<ProductsModel>? products = await productsApi.data(category!);
    return products;
  }

}
