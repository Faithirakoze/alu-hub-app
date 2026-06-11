// PREVIEW ENTRY POINT — run with:  flutter run -t lib/preview_main.dart
//
// A small launcher so you can open each screen on the emulator.
// It only depends on the three files you just added + the theme.

import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/organizer_dashboard_screen.dart';
import 'screens/student_profile_screen.dart';

void main() => runApp(const PreviewApp());

class PreviewApp extends StatelessWidget {
  const PreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const _PreviewLauncher(),
    );
  }
}

class _PreviewLauncher extends StatelessWidget {
  const _PreviewLauncher();

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  _open(context, const OrganizerDashboardScreen()),
              child: const Text('Organizer Dashboard'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _open(context, const StudentProfileScreen()),
              child: const Text('Student Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
