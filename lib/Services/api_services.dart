import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_api/Model/product_model.dart';

class ApiServices {
  static String Url = "https://fakestoreapi.com/products";
  static String loginUrl = "https://fakestoreapi.com/auth/login";

  Future<String> loginService(String username, String password) async {
    try {
      final response = await http.post(Uri.parse(loginUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({"username": username, "password": password}));

      if (response.statusCode == 200) {
        final JsonResponse = json.decode(response.body);
        return JsonResponse['token'];
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<List<ProductModel>?> getServices() async {
    final response = await http.get(Uri.parse(Url));

    if (response.statusCode == 200) {
      print(response.body);

      final List<dynamic> productJson = json.decode(response.body);
      final productData = productJson.map((json) {
        return ProductModel.fromJson(Map<String, dynamic>.from(json));
      }).toList();
      return productData;
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<bool> deleteService(int id) async {
    final response = await http.delete(Uri.parse('$Url/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete product: ${response.statusCode}');
    }
  }

  Future<bool> postService(ProductModel product) async {
    final response = await http.post(
      Uri.parse(Url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "category": product.category,
        "image": product.image,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add product: ${response.statusCode}');
    }
  }

  Future<bool> updateService(ProductModel product) async {
    final response = await http.put(
      Uri.parse('$Url/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "title": product.title,
        "price": product.price,
        "description": product.description,
        "category": product.category,
        "image": product.image,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update product: ${response.statusCode}');
    }
  }
}
