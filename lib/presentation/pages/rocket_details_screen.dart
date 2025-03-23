import 'package:flutter/material.dart';
import 'package:spacex_rockets_app/core/utils/app_utils.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/rocket_provider.dart';

class RocketDetailsScreen extends ConsumerWidget {
  final Rocket rocket;

  const RocketDetailsScreen({super.key, required this.rocket});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rocketDetailsAsyncValue = ref.watch(rocketProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(rocket.name.toString()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh data from the API
              ref.refresh(rocketProvider);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rocket.flickrImages?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(rocket.flickrImages![index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text('Country: ${rocket.country}'),
            Text('Engines: ${rocket.engines?.number}'),
            Text('Active: ${rocket.active! ? 'Yes' : 'No'}'),
            Text('Cost per Launch: \$${rocket.costPerLaunch}'),
            Text('Success Rate: ${rocket.successRatePct}%'),
            Text('Height: ${AppUtils.convertToFeetInches(rocket.height!.meters!.toDouble())}'),
            Text('Diameter: ${AppUtils.convertToFeetInches(rocket.diameter!.meters!.toDouble())}'),
            const SizedBox(height: 16),
            Text(rocket.description.toString()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse(rocket.wikipedia.toString());
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not launch URL')),
                  );
                }
              },
              child: const Text('Open Wikipedia'),
            ),
          ],
        ),
      ),
    );
  }
}