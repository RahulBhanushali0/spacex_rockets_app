import 'package:flutter/material.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';

import '../pages/rocket_details_screen.dart';

class RocketItemWidget extends StatelessWidget {
  final Rocket rocket;

  const RocketItemWidget({super.key, required this.rocket});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(rocket.name.toString()),
      subtitle: Text(rocket.country.toString()),
      leading: Image.network(rocket.flickrImages!.first),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RocketDetailsScreen(rocket: rocket),
          ),
        );
      },
    );
  }
}