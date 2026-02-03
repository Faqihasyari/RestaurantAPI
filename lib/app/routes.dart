import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:permission1/data/repositories/restaurant_repository.dart';
import 'package:permission1/data/services/api_service.dart';
import 'package:permission1/presentasion/pages/restaurant_detail_page.dart';
import 'package:permission1/presentasion/pages/restaurant_list_page.dart';
import 'package:permission1/presentasion/pages/restaurant_search_page.dart';
import 'package:permission1/presentasion/providers/restaurant_detail_provider.dart';
import 'package:permission1/presentasion/providers/restaurant_search_provider.dart';

class AppRoutes {
  static const String home = '/';
  static const String detail = '/detail';
  static const String search = '/search';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const RestaurantListPage(),

    detail: (context) {
      final id = ModalRoute.of(context)!.settings.arguments as String;

      return ChangeNotifierProvider(
        create: (_) => RestaurantDetailProvider(
          repository: RestaurantRepository(apiService: ApiService()),
          restaurantId: id,
        ),
        child: const RestaurantDetailPage(),
      );
    },

    search: (_) {
      return ChangeNotifierProvider(
        create: (_) => RestaurantSearchProvider(
          RestaurantRepository(apiService: ApiService()),
        ),
        child: const RestaurantSearchPage(),
      );
    },
  };
}
