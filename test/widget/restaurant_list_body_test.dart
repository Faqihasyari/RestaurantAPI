import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/core/widgets/listPage/restaurant_list_body.dart';
import 'package:permission1/presentasion/providers/restauran_list_provider.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';
import 'package:provider/provider.dart';

class FakeRepository extends Fake implements RestaurantRepository {}

class FakeProvider extends RestauranListProvider {
  FakeProvider() : super(FakeRepository());

  @override
  ResultState<List<dynamic>> state = Loading();
}

void main() {
  testWidgets('Should show loading indicator when state is Loading', (
    WidgetTester tester,
  ) async {
    final provider = FakeProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<RestauranListProvider>.value(
        value: provider,
        child: const MaterialApp(home: Scaffold(body: RestaurantListBody())),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Memuat restoran...'), findsOneWidget);
  });
}
