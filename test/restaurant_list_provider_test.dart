import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission1/core/utils/result_state.dart';
import 'package:permission1/presentasion/providers/restauran_list_provider.dart';
import 'package:permission1/data/repositories/restaurant_repository.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([RestaurantRepository])
void main() {
  late MockRestaurantRepository mockRepository;
  late RestauranListProvider provider;

  final mockRestaurantList = <dynamic>[
    {"id": "1", "name": "Test"},
  ];

  setUp(() {
    mockRepository = MockRestaurantRepository();
    provider = RestauranListProvider(mockRepository);
  });

  test('Initial state should be Loading', () {
    expect(provider.state, isA<Loading>());
  });

  test('Should return HasData when API call success', () async {
    when(
      mockRepository.getRestaurantList(),
    ).thenAnswer((_) async => mockRestaurantList);

    await provider.fetchRest();

    expect(provider.state, isA<HasData<List<dynamic>>>());
  });

  test('Should return ErrorState when API call fails', () async {
    when(
      mockRepository.getRestaurantList(),
    ).thenAnswer((_) async => throw Exception('Failed'));

    await provider.fetchRest();

    expect(provider.state, isA<ErrorState<List<dynamic>>>());
  });
}
