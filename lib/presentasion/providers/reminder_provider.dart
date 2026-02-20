import 'package:flutter/material.dart';
import 'package:permission1/data/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderProvider extends ChangeNotifier {
  static const _key = 'daily_reminder';

  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  ReminderProvider() {
    _load();
  }

  

  Future<void> toggle(bool value) async {
    _isEnabled = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);

    if (value) {
      await NotificationService.scheduleDailyReminder();
    } else {
      await NotificationService.cancelReminder();
    }

    notifyListeners();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = prefs.getBool(_key) ?? false;

    notifyListeners();
  }
}