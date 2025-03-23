import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:spacex_rockets_app/presentation/providers/rocket_provider.dart';
import 'package:spacex_rockets_app/domain/usecases/get_rockets.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';

class MockGetRockets extends Mock implements GetRockets {}

void main() {
  late ProviderContainer container;
  late MockGetRockets mockGetRockets;

  setUp(() {
    mockGetRockets = MockGetRockets();
    container = ProviderContainer(
      overrides: [
        getRocketsProvider.overrideWithValue(mockGetRockets),
      ],
    );
  });

  test('rocketProvider returns loading state initially', () async {
    // Arrange
    when(mockGetRockets()).thenAnswer((_) async => []);

    // Act
    final provider = container.read(rocketProvider);

    // Assert
    expect(provider, isA<AsyncLoading>());
  });

  test('rocketProvider returns data when successful', () async {
    // Arrange
    when(mockGetRockets()).thenAnswer((_) async => [
      Rocket(name: 'Falcon 9', country: 'USA')
    ]);

    // Act
    final provider = container.read(rocketProvider);

    // Assert
    await expectLater(
      provider,
      isA<AsyncData<List<Rocket>>>().having(
            (data) => data.value.first.name,
        'rocket name',
        'Falcon 9',
      ),
    );
  });
}