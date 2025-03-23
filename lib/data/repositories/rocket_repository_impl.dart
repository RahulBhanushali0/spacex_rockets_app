import 'dart:convert';
import 'package:spacex_rockets_app/data/datasources/spacex_api_service.dart';
import 'package:spacex_rockets_app/data/datasources/local_database.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';
import 'package:spacex_rockets_app/domain/repositories/rocket_repository.dart';
import 'package:spacex_rockets_app/data/models/rocket_model.dart';

class RocketRepositoryImpl implements RocketRepository {
  final SpaceXApiService apiService;
  final LocalDatabase localDatabase;

  RocketRepositoryImpl({required this.apiService, required this.localDatabase});

  @override
  Future<List<Rocket>> getRockets({int page = 1, int limit = 10}) async {
    try {
      final cachedRockets = await localDatabase.getRockets();
      if (cachedRockets.isNotEmpty) {
        return cachedRockets.map((rocket) => _mapToRocketEntity(rocket)).toList();
      }

      final rockets = await apiService.getRockets(page: page, limit: limit);
      for (final rocket in rockets) {
        await localDatabase.insertRocket(rocket);
      }
      return rockets.map((rocket) => RocketModel.fromJson(rocket).toEntity()).toList();
    } catch (e) {
      print('Error fetching rockets: $e');
      throw Exception('Failed to load rockets');
    }
  }

  @override
  Future<Rocket> getRocketDetails(String id) async {
    try {
      final cachedRocket = await localDatabase.getRocketById(id);
      if (cachedRocket != null) {
        return _mapToRocketEntity(cachedRocket);
      }

      final rocket = await apiService.getRocketDetails(id);
      await localDatabase.insertRocket(rocket);
      return RocketModel.fromJson(rocket).toEntity();
    } catch (e) {
      print('Error fetching rocket details: $e');
      throw Exception('Failed to load rocket details');
    }
  }

  Rocket _mapToRocketEntity(Map<String, dynamic> rocket) {
    return Rocket(
      id: rocket['id'],
      name: rocket['name'],
      type: rocket['type'],
      active: rocket['active'] == 1,
      stages: rocket['stages'],
      boosters: rocket['boosters'],
      costPerLaunch: rocket['cost_per_launch'].toDouble(),
      successRatePct: rocket['success_rate_pct'].toDouble(),
      firstFlight: rocket['first_flight'] != null ? DateTime.parse(rocket['first_flight']) : null,
      country: rocket['country'],
      company: rocket['company'],
      wikipedia: rocket['wikipedia'],
      description: rocket['description'],
      flickrImages: List<String>.from(jsonDecode(rocket['flickr_images'])),
      height: Diameter.fromJson(jsonDecode(rocket['height'])),
      diameter: Diameter.fromJson(jsonDecode(rocket['diameter'])),
      mass: Mass.fromJson(jsonDecode(rocket['mass'])),
      firstStage: FirstStage.fromJson(jsonDecode(rocket['first_stage'])),
      secondStage: SecondStage.fromJson(jsonDecode(rocket['second_stage'])),
      engines: Engines.fromJson(jsonDecode(rocket['engines'])),
      landingLegs: LandingLegs.fromJson(jsonDecode(rocket['landing_legs'])),
      payloadWeights: List<PayloadWeight>.from(
        jsonDecode(rocket['payload_weights']).map((x) => PayloadWeight.fromJson(x)),
      ),
    );
  }
}