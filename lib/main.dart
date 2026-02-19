import 'package:flutter/material.dart';
import 'package:permission1/app/app.dart';
import 'package:permission1/data/local/database_helper.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';
import 'package:permission1/data/services/api_service.dart';
import 'package:permission1/presentasion/providers/favorite_provider.dart';
import 'package:permission1/presentasion/providers/navigation_provider.dart';
import 'package:permission1/presentasion/providers/restauran_list_provider.dart';
import 'package:permission1/presentasion/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(DatabaseHelper.instance),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => RestauranListProvider(
            RestaurantRepository(apiService: ApiService()),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
