import 'package:spacex_rockets_app/domain/repositories/rocket_repository.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';

class GetRockets {
  final RocketRepository repository;

  GetRockets(this.repository);

  Future<List<Rocket>> call() async {
    return await repository.getRockets();
  }
}