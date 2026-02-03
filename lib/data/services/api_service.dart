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

  // hit api
  Future<List<dynamic>> getRestaurantList() async {
    final response = await http.get(Uri.parse(getRestaurantDetailUrl()));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['restaurants'];
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  // get restaurant detail
  Future<Map<String, dynamic>> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(getRestaurantByIdUrl(id)));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['restaurant'];
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<List<dynamic>> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(getSearchRestaurantUrl(query)));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['restaurants'];
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<List<dynamic>> addReviewUrl({
  required String restaurantId,
  required String name,
  required String review,
}) async {
  final response = await http.post(
    Uri.parse(addReview()),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'id': restaurantId,
      'name': name,
      'review': review,
    }),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    final decoded = json.decode(response.body);
    return decoded['customerReviews'];
  } else {
    throw Exception('Gagal menambahkan review');
  }
}
}
