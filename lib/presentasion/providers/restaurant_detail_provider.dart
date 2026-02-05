import 'package:flutter/material.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantRepository repository;
  final String restaurantId;

  RestaurantDetailProvider({
    required this.repository,
    required this.restaurantId,
  }) {
    fetchDetail();
  }

  ResultState<Map<String, dynamic>> _state = Loading();
  ResultState<Map<String, dynamic>> get state => _state;

  Future<void> fetchDetail() async {
    try {
      _state = Loading();
      notifyListeners();

      final restaurantDetail =
          await repository.getRestaurantDetail(restaurantId);

      _state = HasData(restaurantDetail);
    } catch (e) {
      _state = ErrorState(e.toString());
    }

    notifyListeners();
  }

  Future<void> addReview({
    required String name,
    required String review,
  }) async {
    try {
      if (_state is! HasData<Map<String, dynamic>>) return;

      final reviews = await repository.addReviewUrl(
        restaurantId: restaurantId,
        name: name,
        review: review,
      );

      final currentData =
          (_state as HasData<Map<String, dynamic>>).data;

      currentData['customerReviews'] = reviews;
      _state = HasData(currentData);
      notifyListeners();
    } catch (e) {
      _state = ErrorState(e.toString());
      notifyListeners();
    }
  }
}