import 'package:flutter/material.dart';
import 'package:permission1/presentasion/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class InfoCard extends StatelessWidget {
  final Map restaurant;
  const InfoCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 20,
                  color: primaryColor.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                restaurant['name'],
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Consumer<FavoriteProvider>(
                builder: (context, favoriteProvider, _) {
                  final isFavorite = favoriteProvider.favorites.any(
                    (item) => item['id'] == restaurant['id'],
                  );

                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () async {
                      if (isFavorite) {
                        await favoriteProvider.removeFavorite(restaurant['id']);
                      } else {
                        await favoriteProvider.addFavorite({
                          'id': restaurant['id'],
                          'name': restaurant['name'],
                          'city': restaurant['city'],
                          'pictureId': restaurant['pictureId'],
                          'rating': restaurant['rating'],
                        });
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _row(
                context,
                Icons.location_on,
                restaurant['city'],
                Colors.red,
                'Kota',
              ),
              const SizedBox(height: 4),
              _divider(),
              const SizedBox(height: 4),
              _row(
                context,
                Icons.home_outlined,
                restaurant['address'],
                Colors.blue,
                'Alamat',
              ),
              const SizedBox(height: 4),
              _divider(),
              const SizedBox(height: 4),
              _row(
                context,
                Icons.star,
                restaurant['rating'].toString(),
                Colors.amber,
                'Rating',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.grey.withValues(alpha: 0.15),
      thickness: 1,
      height: 8,
      indent: 52,
    );
  }

  Widget _row(
    BuildContext context,
    IconData icon,
    String text,
    Color iconColor,
    String label,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 22, color: iconColor),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
