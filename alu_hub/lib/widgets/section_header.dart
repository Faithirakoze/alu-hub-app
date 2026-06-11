// section_header.dart
// "PROGRAM", "CAREER", "CLUBS".
// It's a separate reusable widget because we use it 3 times on the same screen.
// Instead of copy-pasting the same Container 3 times, we pass the title in.
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  // title: the text this header displays, e.g. 'Program', 'Career', 'Clubs'
  // final: once the widget is built, title never changes.
  final String title;

  // required this.title — the caller MUST pass a title, it has no default.
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // double.infinity = "be as wide as your parent allows" = full screen width
      width: double.infinity,

      // Light grey background — matches the section header colour in the design
      color: const Color(0xFFEFEDF0),

      // EdgeInsets.symmetric: 16px left+right, 8px top+bottom
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Text(
        // toUpperCase() converts 'Program' → 'PROGRAM', 'Career' → 'CAREER'
        // The design shows these in all-caps
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6, // 0.6px spacing makes small-caps text more readable
          color: AppColors.onSurfaceVariant, // grey text colour
        ),
      ),
    );
  }
}