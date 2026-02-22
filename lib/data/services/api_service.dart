import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";

  String getRestaurantDetailUrl() {
    return "$baseUrl/list";
  }

  String getRestaurantByIdUrl(String id) {
    return "$baseUrl/detail/$id";
  }

  String getSearchRestaurantUrl(String query) {
    return "$baseUrl/search?q=<$query>";
  }

  String addReview() {
    return "$baseUrl/review";
  }

  Future<List<dynamic>> getRestaurantList() async {
    try {
      final response = await http.get(Uri.parse(getRestaurantDetailUrl()));

      final decoded = json.decode(response.body);
      return decoded['restaurants'];
    } catch (e) {
      throw Exception(
        'Gagal memuat daftar restoran.\nPeriksa koneksi internet Anda.',
      );
    }
  }

  Future<Map<String, dynamic>> getRestaurantDetail(String id) async {
    try {
      final response = await http.get(Uri.parse(getRestaurantByIdUrl(id)));

      final decoded = json.decode(response.body);
      return decoded['restaurant'];
    } catch (e) {
      throw Exception(
        'Gagal memuat detail restoran.\nPeriksa koneksi internet Anda.',
      );
    }
  }

  Future<List<dynamic>> searchRestaurant(String query) async {
    try {
      final response = await http.get(Uri.parse(getSearchRestaurantUrl(query)));

      final decoded = json.decode(response.body);
      return decoded['restaurants'];
    } catch (e) {
      throw Exception(
        'Gagal mencari restoran.\nPeriksa koneksi internet Anda.',
      );
    }
  }

  Future<List<dynamic>> addReviewUrl({
    required String restaurantId,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse(addReview()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': restaurantId, 'name': name, 'review': review}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['customerReviews'];
    } else {
      throw Exception('Gagal menambahkan review');
    }
  }
}
