import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacex_rockets_app/presentation/providers/rocket_provider.dart';
import 'package:spacex_rockets_app/presentation/pages/rocket_details_screen.dart';

class RocketListScreen extends ConsumerWidget {
  const RocketListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rocketsAsyncValue = ref.watch(rocketProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Rockets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(rocketProvider);
            },
          ),
        ],
      ),
      body: rocketsAsyncValue.when(
        data: (rockets) {
          return ListView.builder(
            itemCount: rockets.length,
            itemBuilder: (context, index) {
              final rocket = rockets[index];
              return ListTile(
                title: Text(rocket.name.toString()),
                subtitle: Text(rocket.country.toString()),
                leading: rocket.flickrImages!.isNotEmpty
                    ? Image.network(rocket.flickrImages!.first)
                    : const Icon(Icons.rocket),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RocketDetailsScreen(rocket: rocket),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Failed to load rockets. Please try again.'),
                ElevatedButton(
                  onPressed: () => ref.refresh(rocketProvider),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}