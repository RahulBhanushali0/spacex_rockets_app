import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_rockets_app/presentation/widgets/rocket_item_widget.dart';
import 'package:spacex_rockets_app/domain/entities/rocket.dart';

void main() {
  testWidgets('RocketItemWidget displays rocket name and country', (WidgetTester tester) async {
    // Arrange
    final rocket = Rocket(name: 'Falcon 9', country: 'USA');

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RocketItemWidget(rocket: rocket),
        ),
      ),
    );

    // Assert
    expect(find.text('Falcon 9'), findsOneWidget);
    expect(find.text('USA'), findsOneWidget);
  });
}