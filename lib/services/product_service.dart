import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductService {
  // Update this to your running .NET API port
  final String baseUrl = "https://localhost:7063/api/Products";

  // Returns an empty list instead of null if things crash
  Future<List<Product>> getAllProducts() async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
        return jsonList.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      print("Network log: Failed to load products ($e)");
      return [];
    }
  }

  Future<bool> createProduct(String name, int stock, double qty, String desc) async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "productName": name,
          "stock": stock,
          "qty": qty,
          "productDescription": desc
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateProduct(int id, String name, int stock, double qty, String desc) async {
    final url = Uri.parse('$baseUrl/$id');
    try {
      // 🟢 FIXED: Using http.put with the correct JSON body configuration
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "productName": name,
          "stock": stock,
          "qty": qty,
          "productDescription": desc
        }),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}