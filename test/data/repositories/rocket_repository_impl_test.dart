import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spacex_rockets_app/data/repositories/rocket_repository_impl.dart';
import 'package:spacex_rockets_app/data/datasources/spacex_api_service.dart';
import 'package:spacex_rockets_app/data/datasources/local_database.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';

class MockSpaceXApiService extends Mock implements SpaceXApiService {}
class MockLocalDatabase extends Mock implements LocalDatabase {}

void main() {
  late RocketRepositoryImpl repository;
  late MockSpaceXApiService mockApiService;
  late MockLocalDatabase mockLocalDatabase;

  setUp(() {
    mockApiService = MockSpaceXApiService();
    mockLocalDatabase = MockLocalDatabase();
    repository = RocketRepositoryImpl(
      apiService: mockApiService,
      localDatabase: mockLocalDatabase,
    );
  });

  group('getRockets', () {
    test('should return rockets from API when API call is successful', () async {
      // Arrange
      when(mockApiService.getRockets()).thenAnswer((_) async => [
        {'id': '1', 'name': 'Falcon 9'}
      ]);

      // Act
      final result = await repository.getRockets();

      // Assert
      expect(result.length, 1);
      expect(result.first.name, 'Falcon 9');
      verify(mockApiService.getRockets()).called(1);
    });

    test('should return cached rockets when API call fails', () async {
      // Arrange
      when(mockApiService.getRockets()).thenThrow(Exception('API Error'));
      when(mockLocalDatabase.getRockets()).thenAnswer((_) async => [
        {'id': '1', 'name': 'Falcon 9', 'active': 1}
      ]);

      // Act
      final result = await repository.getRockets();

      // Assert
      expect(result.length, 1);
      expect(result.first.name, 'Falcon 9');
      verify(mockLocalDatabase.getRockets()).called(1);
    });
  });
}