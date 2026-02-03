import 'package:flutter/material.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';

class RestauranListProvider extends ChangeNotifier {
  final RestaurantRepository repository;

  RestauranListProvider(this.repository) {
    fetchRest();
  }

  ResultState<List<dynamic>> _state = Loading();
  ResultState<List<dynamic>> get state => _state;

  Future<void> fetchRest() async {
    try {
      _state = Loading();
      notifyListeners();

      final restaurantList = await repository.fetchRestaurantList();
      _state = HasData(restaurantList);
      notifyListeners();
    } catch (e) {
      // Handle error state if needed
      _state = ErrorState(e.toString());
    }
    notifyListeners();
  }
}
