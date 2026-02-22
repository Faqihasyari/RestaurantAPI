import 'package:flutter/material.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/core/utils/error_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const String dailyTask = "dailyReminderTask";

class ReminderProvider extends ChangeNotifier {
  static const _key = 'daily_reminder';

  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  ResultState<void> _state = HasData(null);
  ResultState<void> get state => _state;

  ReminderProvider() {
    _load();
  }

  Future<void> toggle(bool value) async {
    _state = Loading();
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, value);

      if (value) {
        final now = DateTime.now();
        DateTime scheduled = DateTime(now.year, now.month, now.day, 11);

        if (scheduled.isBefore(now)) {
          scheduled = scheduled.add(const Duration(days: 1));
        }

        final initialDelay = scheduled.difference(now);

        await Workmanager().registerPeriodicTask(
          dailyTask, 
          dailyTask, 
          frequency: const Duration(hours: 24),
          initialDelay: initialDelay,
        );
      } else {
        await Workmanager().cancelByUniqueName(dailyTask);
      }

      _isEnabled = value;
      _state = HasData(null);
    } catch (e) {
      _state = ErrorState(mapErrorToMessage(e));
    }

    notifyListeners();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = prefs.getBool(_key) ?? false;
    notifyListeners();
  }
}
