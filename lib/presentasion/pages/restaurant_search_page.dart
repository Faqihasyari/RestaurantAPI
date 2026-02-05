import 'package:flutter/material.dart';
import 'package:permission1/core/widgets/search/search_bar.dart';
import 'package:permission1/core/widgets/search/search_result_section.dart';
import 'package:permission1/presentasion/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
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
      body: Column(
        children: [
          SearchBarWidget(controller: _controller, focusNode: _focusNode),
          const Expanded(child: SearchResultSection()),
        ],
      ),
    );
  }
}
