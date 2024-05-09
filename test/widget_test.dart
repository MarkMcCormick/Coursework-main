import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speakeasy/screens/exportScreens.dart';
String loggedInUsername = '';
void main() {
  testWidgets('Menu screen widgets test', (WidgetTester tester) async {
    final Size screenSize = Size(600, 800);
    await tester.binding.setSurfaceSize(screenSize);

    await tester.pumpWidget(MaterialApp(
      home: MenuScreen(username: loggedInUsername,),
    ));

    // Test if the "Welcome to SpeakEasy" text is rendered
    expect(find.text('Welcome to SpeakEasy'), findsOneWidget);

    // Test if the image is rendered
    expect(find.byType(Image), findsOneWidget);

    // Test if the "Learn" button is rendered
    expect(find.text('Learn'), findsOneWidget);

    // Test if the bottom navigation bar is rendered
    expect(find.byType(BottomAppBar), findsOneWidget);
  });

  testWidgets('Learn screen widgets test', (WidgetTester tester) async {
    final Size screenSize = Size(600, 800);
    await tester.binding.setSurfaceSize(screenSize);
    await tester.pumpWidget(MaterialApp(
      home: LearnScreen(),
    ));

    // Test if the "Study" button is rendered
    expect(find.text('Study'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2)); // Two buttons in total

    // Test if the "Quiz" button is rendered
    expect(find.text('Quiz'), findsOneWidget);

    // Test if the bottom navigation bar is rendered
    expect(find.byType(BottomAppBar), findsOneWidget);
  });

  testWidgets('Leaderboard page widgets test', (WidgetTester tester) async {
    // Wrap the test in a runAsync to properly handle asynchronous calls
    await tester.runAsync(() async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: LeaderboardPage(),
        ),
      );

      // Verify if the app bar title is rendered
      expect(find.text('Leaderboard'), findsOneWidget);

      // Verify if the podiums are rendered
      expect(find.byType(SizedBox), findsNWidgets(3)); // 3 podiums

      // Verify if the bottom navigation bar is rendered
      expect(find.byType(BottomAppBar), findsOneWidget);
    });
  });

  testWidgets('Settings page widgets test', (WidgetTester tester) async {
    // Wrap the test in a runAsync to properly handle asynchronous calls
    await tester.runAsync(() async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: SettingsPage(),
        ),
      );

      // Verify if the Dark Mode setting is rendered
      expect(find.text('Dark Mode'), findsOneWidget);

      // Verify if the Notifications setting is rendered
      expect(find.text('Notifications'), findsOneWidget);

      // Verify if the Themes setting is rendered
      expect(find.text('Themes'), findsOneWidget);

      // Verify if the Sound setting is rendered
      expect(find.text('Sound On/Off'), findsOneWidget);
    });
  });

}
