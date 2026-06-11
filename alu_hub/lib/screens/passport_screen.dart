// passport_screen.dart
// The Passport screen — shows a student's achievements, badges, and journey.
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/community_app_bar.dart';

class PassportScreen extends StatelessWidget {
  const PassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommunityAppBar(),

      body: SingleChildScrollView(
        // SingleChildScrollView: makes the whole page scrollable.
        // Use this instead of ListView when the content is a single column
        // that isn't a repeating list.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── HEADER CARD ───────────────────────────────────────────────
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  // Avatar + name + badge row
                  Row(
                    children: [
                      // Profile picture circle
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.gold.withOpacity(0.3),
                        backgroundImage: const NetworkImage(
                          'https://ui-avatars.com/api/?name=Chidi+Azikiwe&background=FEAE2C&color=fff&bold=true',
                        ),
                      ),
                      const SizedBox(width: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Chidi Azikiwe',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Honor Society badge pill
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              'HONOR SOCIETY',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.navy,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Year 3 • ALU Mauritius',
                            style: TextStyle(fontSize: 13, color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Stats row: Events, Communities, Roles, Skills
                  Row(
                    // MainAxisAlignment.spaceBetween spreads the 4 stat boxes evenly
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatBox(value: '24', label: 'EVENTS'),
                      _StatBox(value: '12', label: 'COMM.'),
                      _StatBox(value: '05', label: 'ROLES'),
                      _StatBox(value: '18', label: 'SKILLS'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Share Passport button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      // ElevatedButton.icon: a button with both an icon and a label
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navy,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.share_outlined),
                      label: const Text(
                        'Share Passport',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // Remaining sections added in next commits
            const SizedBox(height: 400), // placeholder

          ],
        ),
      ),
    );
  }
}

// _StatBox: one of the 4 stat numbers in the header card.
// Private class (underscore) — only used in this file.
class _StatBox extends StatelessWidget {
  final String value; // the big number e.g. '24'
  final String label; // the small label below e.g. 'EVENTS'
  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        // slightly lighter than navy — a dark grey card feel
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 0.5,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}