import 'package:flutter/material.dart';
import 'package:permission1/core/utils/error_mapper.dart';
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

  bool _isSubmittingReview = false;
  bool get isSubmittingReview => _isSubmittingReview;

  Future<void> fetchDetail() async {
    try {
      _state = Loading();
      notifyListeners();

      final restaurantDetail = await repository.getRestaurantDetail(
        restaurantId,
      );

      _state = HasData(restaurantDetail);
    } catch (e) {
      _state = ErrorState(mapErrorToMessage(e));
    }

    notifyListeners();
  }

  Future<void> addReview({required String name, required String review}) async {
    if (_state is! HasData<Map<String, dynamic>>) return;

    try {
      _isSubmittingReview = true;
      notifyListeners();

      final reviews = await repository.addReviewUrl(
        restaurantId: restaurantId,
        name: name,
        review: review,
      );

      final currentData = (_state as HasData<Map<String, dynamic>>).data;

      final updatedData = Map<String, dynamic>.from(currentData);
      updatedData['customerReviews'] = reviews;

      _state = HasData(updatedData);
    } catch (e) {
      _state = ErrorState(mapErrorToMessage(e));
    } finally {
      _isSubmittingReview = false;
      notifyListeners();
    }
  }
}
