import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task/model/products_model.dart';
import 'package:task/util/api_url.dart';

class ProductsApi {
  Future<List<ProductsModel>?> data(String category) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.products}$category';
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: ProductsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("ProductsStatusCode:: ${response.statusCode}  ProductsBody:: ${response.body}");
      final Iterable jsonResponse = json.decode(response.body);
      List<ProductsModel> products = List<ProductsModel>.from(jsonResponse.map((model)=> ProductsModel.fromJson(model)));
      if (response.statusCode == 200) {
        return products;
      } else {
        throw "Products Error";
      }
    } catch (e) {
      log("Products Error $e");
      return null;
    }
  }
}