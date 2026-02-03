import 'package:flutter/material.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final RestaurantRepository repository;

  RestaurantSearchProvider(this.repository);

  ResultState<List<dynamic>> _state = Loading();
  ResultState<List<dynamic>> get state => _state;

  Future<void> search(String query) async {
    final keyword = query.trim().toLowerCase();

    if (keyword.length < 3) {
      _state = HasData([]);
      notifyListeners();
      return;
    }

    try {
      _state = Loading();
      notifyListeners();

      final result = await repository.searchRestaurant(keyword);

      // 🔥 FILTER SESUAI NAMA RESTORAN
      final filtered = result.where((restaurant) {
        final name = restaurant['name'].toString().toLowerCase();
        return name.contains(keyword);
      }).toList();

      _state = HasData(filtered);
    } catch (e) {
      _state = ErrorState(e.toString());
    }

    notifyListeners();
  }
}
