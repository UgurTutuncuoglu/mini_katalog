import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiService {

 static Future<List<Product>> getProducts() async {
  try {
    final response = await http.get(
      Uri.parse("https://wantapi.com/products.php"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData =
          jsonDecode(response.body);

      final List data = jsonData["data"];

      return data.map((e) => Product.fromJson(e)).toList();
    }

  } catch (error, stackTrace) {
    
    print(stackTrace);
  }

  return [];
}

}