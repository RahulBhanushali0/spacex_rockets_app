import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_rockets_app/domain/usecases/get_rockets.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';
import 'package:spacex_rockets_app/data/repositories/rocket_repository_impl.dart';
import 'package:spacex_rockets_app/data/datasources/spacex_api_service.dart';
import 'package:spacex_rockets_app/data/datasources/local_database.dart';

import '../../domain/repositories/rocket_repository.dart';

final rocketProvider = FutureProvider<List<Rocket>>((ref) async {
  final getRockets = ref.watch(getRocketsProvider);
  return await getRockets();
});

final getRocketsProvider = Provider<GetRockets>((ref) {
  return GetRockets(ref.watch(rocketRepositoryProvider));
});

final rocketRepositoryProvider = Provider<RocketRepository>((ref) {
  return RocketRepositoryImpl(
    apiService: ref.watch(spaceXApiServiceProvider),
    localDatabase: ref.watch(localDatabaseProvider),
  );
});

final spaceXApiServiceProvider = Provider<SpaceXApiService>((ref) {
  return SpaceXApiService();
});

final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabase();
});