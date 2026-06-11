// main.dart
// Application entry point for ALU Hub.
import 'package:flutter/material.dart';
import 'screens/community_directory_screen.dart';
import 'theme/app_theme.dart';

void main() {
  // Initialize and run the application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALU Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const CommunityDirectoryScreen(),
    );
  }
}
