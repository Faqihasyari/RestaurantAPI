import 'package:flutter/material.dart';
import 'package:permission1/presentasion/providers/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'restaurant_list_page.dart';
import 'favorite_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final currentIndex = navProvider.currentIndex;
    final primaryColor = Theme.of(context).primaryColor;

    const pages = [RestaurantListPage(), FavoritePage()];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey(currentIndex),
          child: pages[currentIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: navProvider.changeIndex, // 🔥 tidak pakai setState lagi
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
        ],
      ),
    );
  }
}
