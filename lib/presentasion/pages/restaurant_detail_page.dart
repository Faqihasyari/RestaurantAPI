import 'package:flutter/material.dart';
import 'package:permission1/core/constants/api_constant.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/core/widgets/add_review_form.dart';
import 'package:permission1/core/widgets/detail/description_section.dart';
import 'package:permission1/core/widgets/detail/detail_app_bar.dart';
import 'package:permission1/core/widgets/detail/info_card.dart';
import 'package:permission1/core/widgets/detail/menu_section.dart';
import 'package:permission1/core/widgets/detail/review_section.dart';
import 'package:permission1/presentasion/providers/restaurant_detail_provider.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          if (state is Loading) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: Hero(
                    tag: args['id'],
                    child: Image.network(
                      '${ApiConstant.imageLarge}${args['pictureId']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is HasData<Map<String, dynamic>>) {
            final restaurant = state.data;

            return CustomScrollView(
              slivers: [
                DetailAppBar(restaurant: restaurant),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      InfoCard(restaurant: restaurant),
                      DescriptionSection(
                        description: restaurant['description'],
                      ),
                      MenuSection(
                        title: 'Makanan',
                        items: restaurant['menus']['foods'],
                        icon: Icons.restaurant,
                      ),
                      MenuSection(
                        title: 'Minuman',
                        items: restaurant['menus']['drinks'],
                        icon: Icons.local_drink,
                      ),
                      ReviewsSection(reviews: restaurant['customerReviews']),
                      const AddReviewForm(),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Error'));
        },
      ),
    );
  }
}
