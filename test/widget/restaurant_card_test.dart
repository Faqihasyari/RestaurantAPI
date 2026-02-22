import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:permission1/core/widgets/listPage/restaurant_car.dart';

class MockFunction extends Mock {
  void call();
}

void main() {
  group('RestaurantCard Widget Test', () {
    late Map<String, dynamic> restaurant;
    late MockFunction mockOnTap;
    late Widget widget;

    setUp(() {
      restaurant = {
        "id": "1",
        "name": "Test Restaurant",
        "city": "Test City",
        "rating": 4.5,
        "pictureId": "14",
      };

      mockOnTap = MockFunction();

      widget = MaterialApp(
        home: Scaffold(
          body: RestaurantCard(restaurant: restaurant, onTap: mockOnTap.call),
        ),
      );
    });

    testWidgets('should display restaurant name, city, and rating correctly', (
      tester,
    ) async {
      await tester.pumpWidget(widget);

      expect(find.text('Test Restaurant'), findsOneWidget);
      expect(find.text('Test City'), findsOneWidget);
      expect(find.text('4.5'), findsOneWidget);
    });

    testWidgets('should call onTap when card tapped', (tester) async {
      await tester.pumpWidget(widget);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      verify(mockOnTap()).called(1);
    });
  });
}
