import 'package:flutter/material.dart';
import 'package:permission1/presentasion/providers/restaurant_search_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/result_state.dart';
import 'restaurant_search_card.dart';
import 'empty_state_widget.dart';

class SearchResultSection extends StatelessWidget {
  const SearchResultSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, provider, _) {
        final state = provider.state;

        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorState) {
          return const EmptyStateWidget(
            icon: Icons.wifi_off,
            title: 'Gagal Memuat Data',
            subtitle: 'Coba periksa koneksi internet Anda',
          );
        }

        if (state is HasData<List<dynamic>>) {
          if (state.data.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.search_off,
              title: 'Tidak ada hasil ditemukan',
              subtitle: 'Coba kata kunci lain',
            );
          }

          return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              final restaurant = state.data[index];
              return RestaurantSearchCard(
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
        }

        return const EmptyStateWidget(
          icon: Icons.search,
          title: 'Cari Restoran',
          subtitle: 'Masukkan kata kunci untuk mencari restoran',
        );
      },
    );
  }
}
