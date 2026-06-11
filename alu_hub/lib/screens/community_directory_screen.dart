// community_directory_screen.dart
// This is the Community Directory Hub screen — your formative screen.
// It shows My Communities (grouped by PROGRAM, CAREER, CLUBS) and a Discover tab.
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/community_app_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/community_list_item.dart';

// StatefulWidget: this screen holds a TabController which changes state
// (which tab is active), so it must be Stateful, not Stateless.
class CommunityDirectoryScreen extends StatefulWidget {
  const CommunityDirectoryScreen({super.key});

  @override
  State<CommunityDirectoryScreen> createState() =>
      _CommunityDirectoryScreenState();
}

class _CommunityDirectoryScreenState extends State<CommunityDirectoryScreen>
    // SingleTickerProviderStateMixin gives this State a "ticker" —
    // a clock that TabController uses to animate the sliding tab indicator.
    // Without this mixin, vsync: this would not compile.
    with SingleTickerProviderStateMixin {

  // late: we can't create the TabController until initState() runs,
  // so we declare it as late and assign it there.
  late TabController _tabController;

  // _selectedIndex: tracks which bottom nav item is highlighted.
  // We start at index 2 because Communities is the 3rd item (0-indexed).
  int _selectedIndex = 2;

  @override
  // initState() runs ONCE when this widget first appears on screen.
  // Use it to set up controllers and listeners.
  void initState() {
    super.initState(); // always call super first in initState
    _tabController = TabController(
      length: 2,   // 2 tabs: My Communities (0) and Discover (1)
      vsync: this, // 'this' is the TickerProvider provided by the mixin
    );
  }

  @override
  // dispose() runs when this widget is permanently removed from the tree.
  // We MUST call _tabController.dispose() to free memory and stop the ticker.
  // Forgetting this causes a memory leak.
  void dispose() {
    _tabController.dispose();
    super.dispose(); // always call super last in dispose
  }

  // _onNavItemTapped: called whenever a bottom nav item is tapped.
  // index is the position of the tapped item (0=Home, 1=Explore, 2=Communities, etc.)
  void _onNavItemTapped(int index) {
    setState(() {
      // setState() tells Flutter: "data changed, please redraw the widget".
      // Without setState, the gold highlight won't move to the tapped item.
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: slot at the top of the screen — uses our custom AppBar widget
      appBar: const CommunityAppBar(),

      // backgroundColor: the page background behind all content
      backgroundColor: AppColors.background,

      // body: the main content area between the AppBar and the bottom nav bar
      body: Column(
        children: [

          // ── TAB BAR ─────────────────────────────────────────────────────────
          // The tab bar sits just below the AppBar, pinned at the top of the body.
          // We wrap it in a Container so we can give it a white background.
          Container(
            color: Colors.white,

            // TabBar: renders the two tab labels with the sliding gold underline.
            child: TabBar(
              controller: _tabController, // connect to the TabController above

              // labelColor: text colour of the CURRENTLY SELECTED tab
              labelColor: AppColors.navy,

              // unselectedLabelColor: text colour of tabs that are NOT selected
              unselectedLabelColor: AppColors.onSurfaceVariant,

              // indicatorColor: the colour of the underline that slides between tabs
              indicatorColor: AppColors.gold,

              // indicatorWeight: thickness of the underline in pixels
              indicatorWeight: 3,

              // labelStyle: TextStyle for the active tab label
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),

              // unselectedLabelStyle: TextStyle for inactive tab labels
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),

              tabs: const [
                Tab(text: 'My Communities'), // index 0
                Tab(text: 'Discover'),        // index 1
              ],
            ),
          ),

          // ── TAB VIEWS ────────────────────────────────────────────────────────
          // Expanded: makes TabBarView fill ALL remaining vertical space.
          // Without Expanded inside a Column, TabBarView has no height and crashes.
          Expanded(
            child: TabBarView(
              controller: _tabController, // must use the SAME controller as TabBar
              children: [
                _buildMyCommunitiesTab(), // tab 0 content
                _buildDiscoverTab(),       // tab 1 content
              ],
            ),
          ),

        ],
      ),

      // ── BOTTOM NAVIGATION BAR ─────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: which item to show as active (gold + filled icon)
        currentIndex: _selectedIndex,

        // onTap: called with the index of the item the user tapped
        onTap: _onNavItemTapped,

        // fixed: all items always visible, equally spaced.
        // (The other option, 'shifting', hides labels on inactive items.)
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,   // forces label to show under the active icon
        showUnselectedLabels: true,  // forces label to show under all inactive icons

        // navy background to match the AppBar
        backgroundColor: AppColors.navy,

        // gold for the active item
        selectedItemColor: AppColors.gold,

        // white at 60% opacity for inactive items
        unselectedItemColor: AppColors.white.withOpacity(0.6),

        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
        ),

        // items: exactly 5 nav buttons — order matters, index starts at 0
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),  // outline icon = inactive state
            activeIcon: Icon(Icons.home),     // filled icon = active state
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
            label: 'Communities',             // this is the active tab
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

  // ── MY COMMUNITIES TAB ──────────────────────────────────────────────────────
  // A private method that returns the widget for tab 0.
  // Methods starting with _ are private — only usable inside this file.
  Widget _buildMyCommunitiesTab() {
    // ListView: a scrollable vertical list.
    // children: we list all the widgets in order — headers and rows mixed.
    return ListView(
      // ClampingScrollPhysics: removes the iOS rubber-band bounce effect.
      // Makes scroll feel the same on Android and iOS.
      physics: const ClampingScrollPhysics(),

      children: [

        // ── PROGRAM SECTION ─────────────────────────────────────────────────
        const SectionHeader(title: 'Program'),

        CommunityListItem(
          icon: Icons.computer_outlined,
          avatarColor: AppColors.gold,       // gold circle background
          iconColor: Colors.white,
          name: 'BSE Year 2 Core',
          subtitle: "Sarah: Don't forget the assignment...",
          timestamp: '14:20',
          unreadCount: 3,                    // shows badge with "3"
          onTap: () {}, // ripple shows, no message — clean UX
        ),

        CommunityListItem(
          icon: Icons.business_center_outlined,
          avatarColor: AppColors.navy,       // navy circle background
          iconColor: Colors.white,
          name: 'Entrepreneurship Lab',
          subtitle: 'Join the pitch session today!',
          timestamp: 'Yesterday',
          // no unreadCount = no badge shown (defaults to null)
          onTap: () {}, // ripple shows, no message — clean UX
        ),

        // 8px spacer between sections to breathe
        const SizedBox(height: 8),

        // ── CAREER SECTION ───────────────────────────────────────────────────
        const SectionHeader(title: 'Career'),

        CommunityListItem(
          icon: Icons.terminal_outlined,
          avatarColor: const Color(0xFF2D1601), // dark brown circle
          iconColor: const Color(0xFFFFDDB4),   // peach icon
          name: 'Tech Internship Hub',
          subtitle: 'New role at Microsoft Africa...',
          timestamp: 'Tue',
          unreadCount: 12,
          onTap: () {}, // ripple shows, no message — clean UX
        ),

        const SizedBox(height: 8),

        // ── CLUBS SECTION ────────────────────────────────────────────────────
        const SectionHeader(title: 'Clubs'),

        CommunityListItem(
          icon: Icons.sports_soccer_outlined,
          avatarColor: const Color(0xFFFFDDB4), // peach circle
          iconColor: const Color(0xFF2D1601),   // dark brown icon
          name: 'ALU Football Club',
          subtitle: 'Training starts at 5 PM sharp.',
          timestamp: 'Mon',
          // no badge
          onTap: () {}, // ripple shows, no message — clean UX
        ),

      ],
    );
  }

  // ── DISCOVER TAB ────────────────────────────────────────────────────────────
  // Returns the widget for tab 1.
 
  Widget _buildDiscoverTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // vertically centered
        children: [
          Icon(
            Icons.explore_outlined,
            size: 64,
            color: AppColors.onSurfaceVariant, // grey icon
          ),
          SizedBox(height: 16), // 16px gap between icon and text
          Text(
            'Discover communities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coming soon',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}