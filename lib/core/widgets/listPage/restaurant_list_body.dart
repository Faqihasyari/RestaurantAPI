import 'package:flutter/material.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/core/widgets/listPage/restaurant_car.dart';
import 'package:permission1/presentasion/providers/restauran_list_provider.dart';
import 'package:provider/provider.dart';
import 'error_view.dart';

class RestaurantListBody extends StatelessWidget {
  const RestaurantListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestauranListProvider>(
      builder: (context, provider, _) {
        final state = provider.state;

        // Loading State
        if (state is Loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  'Memuat restoran...',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // Error State
        if (state is ErrorState<List<dynamic>>) {
          return ErrorView(
            message: state.message,
            onRetry: () {
              provider.fetchRest();
            },
          );
        }

        // Has Data State
        if (state is HasData<List<dynamic>>) {
          if (state.data.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.restaurant_outlined,
                        size: 64,
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Tidak Ada Restoran',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Belum ada restoran yang tersedia',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await provider.fetchRest();
            },
            color: Theme.of(context).primaryColor,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final restaurant = state.data[index];

                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 300 + (index * 50)),
                  child: RestaurantCard(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: restaurant,
                      );
                    },
                  ),
                );
              },
            ),
          );
        }

        // Default State - jika tidak ada state yang cocok
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Tidak Ada Data',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Data tidak tersedia saat ini',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
