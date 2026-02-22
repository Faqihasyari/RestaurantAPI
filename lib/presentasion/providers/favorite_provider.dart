import 'package:flutter/material.dart';
import '../../core/utils/result_state.dart';
import '../../data/local/database_helper.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteProvider(this.databaseHelper);

  ResultState<List<Map<String, dynamic>>> _state = Loading();
  ResultState<List<Map<String, dynamic>>> get state => _state;

  Future<void> loadFavorites() async {
    try {
      _state = Loading();
      notifyListeners();

      final result = await databaseHelper.getFavorites();

      _state = HasData(result);
    } catch (e) {
      _state = ErrorState('Gagal memuat daftar favorit.\nSilakan coba lagi.');
    }

    notifyListeners();
  }

  Future<void> addFavorite(Map<String, dynamic> restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      await loadFavorites();
    } catch (e) {
      _state = ErrorState('Gagal menambahkan ke favorit.');
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      await loadFavorites();
    } catch (e) {
      _state = ErrorState('Gagal menghapus dari favorit.');
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    try {
      return await databaseHelper.isFavorite(id);
    } catch (_) {
      return false;
    }
  }
}
