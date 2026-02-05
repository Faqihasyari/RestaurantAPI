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

        if (state is HasData<List<dynamic>>) {
          if (state.data.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.search_off,
              title: 'No Result',
              subtitle: 'Try different keyword',
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
                    arguments: restaurant['id'],
                  );
                },
              );
            },
          );
        }

        return const EmptyStateWidget(
          icon: Icons.search,
          title: 'Search Restaurant',
          subtitle: 'Start typing to search',
        );
      },
    );
  }
}
