import 'package:flutter/material.dart';
import 'package:permission1/presentasion/providers/restaurant_search_provider.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          context.read<RestaurantSearchProvider>().search(value);
        },
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Cari restoran...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    controller.clear();
                    context.read<RestaurantSearchProvider>().search('');
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
