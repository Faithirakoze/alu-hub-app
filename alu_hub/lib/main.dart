// main.dart
// Entry point of the app — Flutter always starts here.
import 'package:flutter/material.dart';
import 'screens/communities_screen.dart'; // existing screen
import 'theme/app_theme.dart';            // existing theme

void main() {
  // runApp() takes a widget and makes it fill the screen.
  // Everything in the app lives inside this widget tree.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALU Hub',
      debugShowCheckedModeBanner: false, // hides the red DEBUG ribbon
      theme: AppTheme.theme,             // uses the theme from app_theme.dart
      home: const CommunitiesScreen(),   // first screen shown on launch
    );
  }
}
