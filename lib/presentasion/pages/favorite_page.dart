import 'package:flutter/material.dart';
import 'package:permission1/presentasion/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../../core/widgets/listPage/restaurant_car.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<FavoriteProvider>().loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, _) {
          if (provider.favorites.isEmpty) {
            return const Center(child: Text("Belum ada restoran favorit"));
          }

          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final restaurant = provider.favorites[index];
              return RestaurantCard(
                restaurant: restaurant,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: restaurant,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
