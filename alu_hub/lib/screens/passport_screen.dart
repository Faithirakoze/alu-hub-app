import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/community_app_bar.dart';
import '../models/mock_data.dart';

class PassportScreen extends StatelessWidget {
  const PassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommunityAppBar(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── HEADER CARD ─────────────────────────────────────────────────
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

                  // Avatar + name + badge + year row
                  Row(
                    children: [
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
                          // Honor Society pill badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
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
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Stats row: Events, Communities, Roles, Skills
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _StatBox(value: '24', label: 'EVENTS'),
                      _StatBox(value: '12', label: 'COMM.'),
                      _StatBox(value: '05', label: 'ROLES'),
                      _StatBox(value: '18', label: 'SKILLS'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Share Passport button — gold, full width
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navy,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.share_outlined),
                      label: const Text(
                        'Share Passport',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // ── VERIFIED BADGES SECTION ──────────────────────────────────────
            _buildBadgesSection(),

            // ── THE JOURNEY SECTION ──────────────────────────────────────────
            _buildJourneySection(),

            // Bottom padding so content isn't hidden behind nav bar
            const SizedBox(height: 24),
          ],
        ),
      ),

      // ── BOTTOM NAVIGATION BAR ────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex 3 = Passport (0=Home, 1=Explore, 2=Communities, 3=Passport, 4=Profile)
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navy,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.white.withOpacity(0.6),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/explore-resources');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/communities');
              break;
            case 3:
              break; // already here
            case 4:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            activeIcon: Icon(Icons.groups),
            label: 'Communities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style_outlined),
            activeIcon: Icon(Icons.style),
            label: 'Passport',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ── BADGES SECTION ────────────────────────────────────────────────────────
  Widget _buildBadgesSection() {
    // Each map is one badge — icon and label.
    final badges = [
      {'icon': Icons.school_outlined,  'label': 'Academic\nExcellence'},
      {'icon': Icons.groups_outlined,  'label': 'Community\nLeader'},
      {'icon': Icons.bolt_outlined,    'label': 'Agile\nCatalyst'},
      {'icon': Icons.public_outlined,  'label': 'Global\nCitizen'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Section title + View All link on same row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Verified Badges',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // SizedBox with fixed height wraps a horizontal ListView
          SizedBox(
            height: 100,
            child: ListView.builder(
              // scrollDirection: Axis.horizontal = scrolls left and right
              scrollDirection: Axis.horizontal,
              itemCount: badges.length,
              itemBuilder: (context, index) {
                final badge = badges[index];
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      // Badge icon box — light grey rounded square
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEDF0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          badge['icon'] as IconData,
                          color: AppColors.gold,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        badge['label'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.onSurfaceVariant,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ── JOURNEY SECTION ───────────────────────────────────────────────────────
  Widget _buildJourneySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'The Journey',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),

          const SizedBox(height: 16),

          // Build one timeline row for each item in mockJourneyItems
          // The ... spread operator unpacks the list into the Column's children
          ...mockJourneyItems.map((item) => _buildTimelineItem(item)),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // One row in the timeline — coloured dot + vertical line + text block.
  Widget _buildTimelineItem(JourneyItem item) {
    return IntrinsicHeight(
      // IntrinsicHeight forces the Row's children to all be the same height.
      // This makes the vertical line stretch to match the text block.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Left side: dot + vertical connecting line
          Column(
            children: [
              // The dot — gold if highlighted, dark brown otherwise
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: item.isHighlighted
                      ? AppColors.gold
                      : const Color(0xFF2D1601),
                  shape: BoxShape.circle,
                ),
              ),
              // Expanded line fills the remaining height of the row
              Expanded(
                child: Container(
                  width: 2,
                  color: const Color(0xFFEFEDF0), // light grey line
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Right side: date, title, description
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value; // the big number e.g. '24'
  final String label; // small label below e.g. 'EVENTS'
  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        // white at 10% opacity = subtle lighter box inside the navy card
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
