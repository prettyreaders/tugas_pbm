import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/produk.dart';

class ApiService {
  static const String baseUrl = 'https://task.itprojects.web.id';

  // ── AUTH ──────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final url = Uri.parse('$baseUrl/api/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  // ── PRODUCTS ──────────────────────────────────────────────────────────────

  static Future<List<ProductModel>> getProducts(String token) async {
    final url = Uri.parse('$baseUrl/api/products');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      final List list = data['data']['products'];
      return list.map((e) => ProductModel.fromJson(e)).toList();
    }
    return [];
  }

  static Future<Map<String, dynamic>> addProduct(
      String token, String name, int price, String description) async {
    final url = Uri.parse('$baseUrl/api/products');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> deleteProduct(
      String token, int id) async {
    final url = Uri.parse('$baseUrl/api/products/$id');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return jsonDecode(response.body);
  }

  // ── SUBMIT ────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> submitTugas(
    String token,
    String name,
    int price,
    String description,
    String githubUrl,
  ) async {
    final url = Uri.parse('$baseUrl/api/products/submit');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
        'github_url': githubUrl,
      }),
    );
    return jsonDecode(response.body);
  }
}