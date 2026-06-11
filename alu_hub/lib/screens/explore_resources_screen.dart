import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ExploreResourcesScreen extends StatefulWidget {
  const ExploreResourcesScreen({super.key, required this.selectedInterests});

  final List<String> selectedInterests;

  @override
  State<ExploreResourcesScreen> createState() => _ExploreResourcesScreenState();
}

class _ExploreResourcesScreenState extends State<ExploreResourcesScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 1;
  String _selectedCategory = 'All';

  final List<_ResourceData> _resources = const [
    _ResourceData(
      title: 'Tuition Payment Portal',
      subtitle: 'Access semester billing, deadlines, and payment options.',
      category: 'Finance',
      icon: Icons.account_balance_wallet_outlined,
      accentColor: Color(0xFFF59E0B),
      url: 'https://student.alueducation.com/s/payments',
    ),
    _ResourceData(
      title: 'Scholarship Applications',
      subtitle: 'Find active grants and submission timelines.',
      category: 'Academic',
      icon: Icons.school_outlined,
      accentColor: Color(0xFF2563EB),
      url: 'https://africademics.com/',
    ),
    _ResourceData(
      title: 'Expense Tracking 101',
      subtitle: 'Budget templates and practical monthly planning tools.',
      category: 'Finance',
      icon: Icons.analytics_outlined,
      accentColor: Color(0xFF14B8A6),
      url: 'https://www.notion.com/templates/student-budget-tracker',
    ),
    _ResourceData(
      title: 'Wellness Check-ins',
      subtitle: 'Stress support, counseling, and campus health pointers.',
      category: 'Wellness',
      icon: Icons.favorite_border_rounded,
      accentColor: Color(0xFF8B5CF6),
      url: 'https://student.alueducation.com/s/student-resources',
    ),
    _ResourceData(
      title: 'Study Circle Finder',
      subtitle: 'Create a peer group for revision and accountability.',
      category: 'Community',
      icon: Icons.groups_outlined,
      accentColor: Color(0xFFE67E22),
      url: 'https://student.alueducation.com/s/student-resources',
    ),
  ];

  final List<_MentorData> _mentors = const [
    _MentorData(name: 'Sarah K.', track: 'Business', isDarkCard: true),
    _MentorData(name: 'David O.', track: 'Tech', isDarkCard: false),
    _MentorData(name: 'Amina N.', track: 'Wellness', isDarkCard: false),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _categories {
    final categories = <String>{'All', ...widget.selectedInterests};
    return categories.toList();
  }

  List<_ResourceData> get _filteredResources {
    final query = _searchController.text.trim().toLowerCase();
    return _resources.where((resource) {
      final matchesCategory =
          _selectedCategory == 'All' || resource.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          resource.title.toLowerCase().contains(query) ||
          resource.subtitle.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open this link.')),
        );
      }
    }
  }

  void _showMentorActions(BuildContext context, _MentorData mentor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            // mentor info
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.person_outline_rounded,
                      color: AppColors.white),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mentor.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      mentor.track,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textGrey,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // DM button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                label: const Text(
                  'Send a Direct Message',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Opening chat with ${mentor.name}...')),
                  );
                  // TODO: Navigator.push to DirectMessageScreen(mentor: mentor)
                },
              ),
            ),
            const SizedBox(height: 10),
            // Book office hours button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.navy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: AppColors.navy),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.calendar_month_outlined, size: 18),
                label: const Text(
                  'Book Office Hours',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Booking office hours with ${mentor.name}...')),
                  );
                  // TODO: Navigator.push to BookOfficeHoursScreen(mentor: mentor)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = _categories;
    final resources = _filteredResources;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: AppColors.gold.withOpacity(0.18),
            child: const Icon(Icons.person_outline_rounded,
                color: AppColors.white, size: 18),
          ),
        ),
        title: const Text(
          'ALUHub',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded,
                color: AppColors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Notifications are coming next.')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
        children: [
          // ── Hero banner ────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF17284D), Color(0xFF0D1B33)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your ALU feed',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.selectedInterests.isEmpty
                      ? 'Curated resources, mentors, and opportunities for students.'
                      : 'Curated around ${widget.selectedInterests.join(', ')}.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withOpacity(0.78),
                      ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: 'Search resources...',
                    hintStyle:
                        TextStyle(color: AppColors.white.withOpacity(0.65)),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: AppColors.white),
                    filled: true,
                    fillColor: AppColors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // ── Focus area chips ───────────────────────────────────────
          Text(
            'Focus areas',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategory == category;
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  showCheckmark: false,
                  selectedColor: AppColors.navy,
                  backgroundColor: AppColors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) =>
                      setState(() => _selectedCategory = category),
                );
              },
            ),
          ),
          const SizedBox(height: 18),

          // ── Resources ──────────────────────────────────────────────
          Text(
            'Resources',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (resources.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  const Icon(Icons.search_off_rounded,
                      size: 42, color: AppColors.textGrey),
                  const SizedBox(height: 10),
                  Text(
                    'No resources match your filter.',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Try a different category or clear the search term.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...resources.map(
              (resource) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ResourceTile(
                  resource: resource,
                  onTap: () => _launchUrl(resource.url),
                ),
              ),
            ),
          const SizedBox(height: 8),

          // ── Featured mentors ───────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured mentors',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigator.push to AllMentorsScreen
                },
                child: Text(
                  'View all',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 132,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _mentors.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => _MentorCard(
                data: _mentors[index],
                onTap: () => _showMentorActions(context, _mentors[index]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navy,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.white.withOpacity(0.55),
        onTap: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/communities');
              break;
            // add cases for 3 (Passport) and 4 (Profile) when ready
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_rounded), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups_rounded), label: 'Communities'),
          BottomNavigationBarItem(
              icon: Icon(Icons.badge_outlined), label: 'Passport'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _ResourceData {
  const _ResourceData({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.accentColor,
    required this.url,
  });

  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color accentColor;
  final String url;
}

class _MentorData {
  const _MentorData({
    required this.name,
    required this.track,
    required this.isDarkCard,
  });

  final String name;
  final String track;
  final bool isDarkCard;
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _ResourceTile extends StatelessWidget {
  const _ResourceTile({required this.resource, required this.onTap});

  final _ResourceData resource;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: resource.accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(resource.icon, color: resource.accentColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          resource.title,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          resource.category,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.navy,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    resource.subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  // "Open link" hint
                  Row(
                    children: [
                      Icon(Icons.open_in_new_rounded,
                          size: 13, color: AppColors.textGrey),
                      const SizedBox(width: 4),
                      Text(
                        'Open link',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.textGrey,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MentorCard extends StatelessWidget {
  const _MentorCard({required this.data, required this.onTap});

  final _MentorData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = data.isDarkCard ? AppColors.navy : AppColors.white;
    final foregroundColor =
        data.isDarkCard ? AppColors.white : AppColors.textDark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 146,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.star_border_rounded, color: AppColors.gold),
            const Spacer(),
            Text(
              data.track,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: foregroundColor.withOpacity(0.82),
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              data.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}