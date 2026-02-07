import 'package:flutter/material.dart';
import 'package:permission1/core/utils/error_mapper.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final RestaurantRepository repository;

  RestaurantSearchProvider(this.repository) {
    fetchInitial();
  }

  ResultState<List<dynamic>> _state = Loading();
  ResultState<List<dynamic>> get state => _state;

  Future<void> fetchInitial() async {
    try {
      _state = Loading();
      notifyListeners();

      final result = await repository.fetchRestaurantList();
      _state = HasData(result);
    } catch (e) {
      _state = ErrorState(mapErrorToMessage(e));
    }

    notifyListeners();
  }

  Future<void> search(String query) async {
    final keyword = query.trim().toLowerCase();

    try {
      _state = Loading();
      notifyListeners();

      final result = await repository.searchRestaurant(keyword);

      final filtered = result.where((restaurant) {
        final name = restaurant['name'].toString().toLowerCase();
        return name.contains(keyword);
      }).toList();

      _state = HasData(filtered);
    } catch (e) {
      _state = ErrorState(mapErrorToMessage(e));
    }

    notifyListeners();
  }
}
