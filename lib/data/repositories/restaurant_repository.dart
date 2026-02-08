import 'package:permission1/data/services/api_service.dart';

class RestaurantRepository {
  final ApiService apiService;

  RestaurantRepository({required this.apiService});

  Future<List<dynamic>> fetchRestaurantList() async {
    return await apiService.getRestaurantList();
  }

  Future<Map<String, dynamic>> getRestaurantDetail(String id) async {
    return await apiService.getRestaurantDetail(id);
  }

  Future<List<dynamic>> searchRestaurant(String query) async {
    return await apiService.searchRestaurant(query);
  }

  Future<List<dynamic>> addReviewUrl({
    required String restaurantId,
    required String name,
    required String review,
  }) async {
    return await apiService.addReviewUrl(
      restaurantId: restaurantId,
      name: name,
      review: review,
    );
  }
}
