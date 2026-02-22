import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:permission1/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Navigation Integration Test', () {
    testWidgets('Initial page should show Restaurants title', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Restaurants'), findsOneWidget);
    });

    testWidgets('Should navigate to Search page when search button tapped', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.text('Search Restaurant'), findsOneWidget);
    });

    testWidgets('Should navigate to Setting page and show toggle switch', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.text('Pengaturan'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });
  });
}
