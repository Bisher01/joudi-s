import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:task/util/api_url.dart';

class CategoryApi {
  Future<List<String>?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.categories}';
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: CategoriesResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("CategoriesStatusCode:: ${response.statusCode}  CategoriesBody:: ${response.body}");
      final Iterable jsonResponse = json.decode(response.body);
      List<String> categories = List<String>.from(jsonResponse.map((model)=> model));
      if (response.statusCode == 200) {
        return categories;
      } else {
        throw "Categories Error";
      }
    } catch (e) {
      log("Categories Error $e");
      return null;
    }
  }
}