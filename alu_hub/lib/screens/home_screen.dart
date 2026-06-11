import 'package:flutter/material.dart';
import '../models/mock_data.dart';
import 'opportunity_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Opportunity> get _filtered {
    return mockOpportunities.where((o) {
      final matchesCategory = _selectedCategory == 'All' ||
          o.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          o.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildAlertBanner(),
            _buildSearchBar(),
            _buildCategoryChips(),
            Expanded(child: _buildFeed()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0B1B3D),
        currentIndex: 0,
        selectedItemColor: const Color(0xFFF5A623),
        unselectedItemColor: Colors.white.withOpacity(0.55),
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/explore-resources');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/communities');
              break;
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

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFF5A623),
            child: Text(
              AppUser.name[0],
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey ${AppUser.name} 👋',
                style: const TextStyle(
                  color: Color(0xFF0B1B3D),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppUser.program,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Color(0xFF0B1B3D)),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5A623),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5A623).withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF5A623).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: Color(0xFFF5A623), size: 18),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Scholarship deadline in 2 days',
              style: TextStyle(
                  color: Color(0xFF8A6D3B),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'VIEW →',
              style: TextStyle(
                color: Color(0xFFF5A623),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        onChanged: (val) => setState(() => _searchQuery = val),
        decoration: InputDecoration(
          hintText: 'Search opportunities, events...',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          filled: true,
          fillColor: const Color(0xFF1B2B4B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: feedCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final cat = feedCategories[i];
          final isSelected = cat == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0B1B3D) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF4A5568),
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeed() {
    final items = _filtered;
    if (items.isEmpty) {
      return const Center(
        child: Text('No opportunities found',
            style: TextStyle(color: Colors.black38)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: items.length,
      itemBuilder: (context, i) => _OpportunityCard(
        opportunity: items[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            // ← fix: correct screen name
            builder: (_) => OpportunityScreen(opportunity: items[i]),
          ),
        ),
        onBookmark: () => setState(() {
          items[i].isBookmarked = !items[i].isBookmarked;
        }),
        // ← fix: RSVP from card also updates state
        onRSVP: () => setState(() {
          items[i].hasRSVPd = !items[i].hasRSVPd;
          items[i].registeredCount += items[i].hasRSVPd ? 1 : -1;
        }),
      ),
    );
  }
}

class _OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  final VoidCallback onTap;
  final VoidCallback onBookmark;
  final VoidCallback onRSVP; // ← new

  const _OpportunityCard({
    required this.opportunity,
    required this.onTap,
    required this.onBookmark,
    required this.onRSVP,
  });

  Color get _categoryColor {
    switch (opportunity.category.toUpperCase()) {
      case 'CAREER':   return const Color(0xFF1B2B4B);
      case 'FINANCE':  return const Color(0xFFF5A623);
      case 'SOCIAL':   return const Color(0xFF7ED321);
      case 'WELLNESS': return const Color(0xFF9B59B6);
      default:         return const Color(0xFF1B2B4B);
    }
  }

  Color get _actionColor {
    if (opportunity.hasRSVPd) return Colors.black.withOpacity(0.05);
    switch (opportunity.actionLabel) {
      case 'RSVP':  return const Color(0xFFF5A623);
      case 'Apply': return const Color(0xFF1B2B4B);
      case 'Join':  return const Color(0xFF7ED321);
      default:      return const Color(0xFFF5A623);
    }
  }

  Color get _actionForegroundColor {
    if (opportunity.hasRSVPd) return const Color(0xFF0B1B3D);
    switch (opportunity.actionLabel) {
      case 'Apply': return Colors.white;
      default:      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  opportunity.category,
                  style: TextStyle(
                    color: _categoryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onBookmark,
                  child: Icon(
                    opportunity.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: opportunity.isBookmarked
                        ? const Color(0xFFF5A623)
                        : Colors.black26,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              opportunity.title,
              style: const TextStyle(
                color: Color(0xFF0B1B3D),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    color: Colors.black38, size: 13),
                const SizedBox(width: 4),
                Text(opportunity.date,
                    style: const TextStyle(
                        color: Colors.black54, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    color: Colors.black38, size: 13),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    opportunity.location,
                    style: const TextStyle(
                        color: Colors.black54, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              opportunity.description,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 22,
                  child: Stack(
                    children: List.generate(
                      3,
                      (i) => Positioned(
                        left: i * 14.0,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: const Color(0xFF0B1B3D)
                                .withOpacity(0.4 - i * 0.1),
                            child: Text(
                              ['A', 'B', 'C'][i],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // ← fix: wired up onRSVP, reflects hasRSVPd state
                ElevatedButton(
                  onPressed: onRSVP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _actionColor,
                    foregroundColor: _actionForegroundColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (opportunity.hasRSVPd) ...[
                        const Icon(Icons.check_circle, size: 13),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        opportunity.hasRSVPd
                            ? 'Registered'
                            : opportunity.actionLabel,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}