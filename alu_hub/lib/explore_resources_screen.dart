import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

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
    ),
    _ResourceData(
      title: 'Scholarship Applications',
      subtitle: 'Find active grants and submission timelines.',
      category: 'Academic',
      icon: Icons.school_outlined,
      accentColor: Color(0xFF2563EB),
    ),
    _ResourceData(
      title: 'Expense Tracking 101',
      subtitle: 'Budget templates and practical monthly planning tools.',
      category: 'Finance',
      icon: Icons.analytics_outlined,
      accentColor: Color(0xFF14B8A6),
    ),
    _ResourceData(
      title: 'Wellness Check-ins',
      subtitle: 'Stress support, counseling, and campus health pointers.',
      category: 'Wellness',
      icon: Icons.favorite_border_rounded,
      accentColor: Color(0xFF8B5CF6),
    ),
    _ResourceData(
      title: 'Study Circle Finder',
      subtitle: 'Create a peer group for revision and accountability.',
      category: 'Community',
      icon: Icons.groups_outlined,
      accentColor: Color(0xFFE67E22),
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
    _searchController.addListener(() {
      setState(() {});
    });
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
      final matchesCategory = _selectedCategory == 'All' || resource.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          resource.title.toLowerCase().contains(query) ||
          resource.subtitle.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
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
            child: const Icon(Icons.person_outline_rounded, color: AppColors.white, size: 18),
          ),
        ),
        title: const Text(
          'ALUHub',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications are coming next.')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
        children: [
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
                    hintStyle: TextStyle(color: AppColors.white.withOpacity(0.65)),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.white),
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
          Text(
            'Focus areas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
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
                  onSelected: (_) => setState(() => _selectedCategory = category),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Resources',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
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
                  const Icon(Icons.search_off_rounded, size: 42, color: AppColors.textGrey),
                  const SizedBox(height: 10),
                  Text(
                    'No resources match your filter.',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
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
                child: _ResourceTile(resource: resource),
              ),
            ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured mentors',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                'View all',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w600,
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
              itemBuilder: (context, index) => _MentorCard(data: _mentors[index]),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigation item ${index + 1} tapped.')),
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_rounded), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_rounded), label: 'Communities'),
          BottomNavigationBarItem(icon: Icon(Icons.badge_outlined), label: 'Passport'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _ResourceData {
  const _ResourceData({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color accentColor;
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

class _ResourceTile extends StatelessWidget {
  const _ResourceTile({required this.resource});

  final _ResourceData resource;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        resource.category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MentorCard extends StatelessWidget {
  const _MentorCard({required this.data});

  final _MentorData data;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = data.isDarkCard ? AppColors.navy : AppColors.white;
    final foregroundColor = data.isDarkCard ? AppColors.white : AppColors.textDark;

    return Container(
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
    );
  }
}