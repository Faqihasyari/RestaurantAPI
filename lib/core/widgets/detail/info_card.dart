import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Map restaurant;
  const InfoCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
          const SizedBox(height: 16),
          _row(
            context,
            Icons.home_outlined,
            restaurant['address'],
            Colors.blue,
            'Alamat',
          ),
          const SizedBox(height: 16),
          _row(
            context,
            Icons.star,
            restaurant['rating'].toString(),
            Colors.amber,
            'Rating',
          ),
        ],
      ),
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
