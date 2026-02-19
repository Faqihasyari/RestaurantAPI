import 'package:flutter/material.dart';
import '../../data/local/database_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider(this.databaseHelper);

  List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> get favorites => _favorites;

  Future<void> loadFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(Map<String, dynamic> restaurant) async {
    await databaseHelper.insertFavorite(restaurant);
    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await databaseHelper.deleteFavorite(id);
    await loadFavorites();
  }

  Future<bool> isFavorite(String id) async {
    return await databaseHelper.isFavorite(id);
  }
}
