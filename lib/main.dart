import 'dart:math';

import 'package:flutter/material.dart';
import 'package:permission1/app/app.dart';
import 'package:permission1/data/local/database_helper.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';
import 'package:permission1/data/services/api_service.dart';
import 'package:permission1/data/services/notification_service.dart';
import 'package:permission1/presentasion/pages/favorite_page.dart';
import 'package:permission1/presentasion/providers/favorite_provider.dart';
import 'package:permission1/presentasion/providers/navigation_provider.dart';
import 'package:permission1/presentasion/providers/reminder_provider.dart';
import 'package:permission1/presentasion/providers/restauran_list_provider.dart';
import 'package:permission1/presentasion/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

const String dailyTask = "dailyReminderTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == dailyTask) {
      final apiService = ApiService();

      try {
        final restaurants = await apiService.getRestaurantList();

        if (restaurants.isNotEmpty) {
          final random = Random();
          final randomRestaurant =
              restaurants[random.nextInt(restaurants.length)];

          await NotificationService.showSimpleNotification(
            title: "Rekomendasi Hari Ini 🍽️",
            body: "${randomRestaurant['name']} - ${randomRestaurant['city']}",
          );
        }
      } catch (_) {}

      return Future.value(true);
    }

    return Future.value(false);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();

  await Workmanager().initialize(callbackDispatcher);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ReminderProvider()),

        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final provider = FavoriteProvider(DatabaseHelper.instance);
            provider.loadFavorites();
            return provider;
          },
          child: const FavoritePage(),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final provider = RestauranListProvider(
              RestaurantRepository(apiService: ApiService()),
            );
            provider.fetchRest();
            return provider;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}
