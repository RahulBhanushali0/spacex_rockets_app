import 'package:spacex_rockets_app/domain/entities/rocket.dart';

abstract class RocketRepository {
  Future<List<Rocket>> getRockets();
  Future<Rocket> getRocketDetails(String id);
}