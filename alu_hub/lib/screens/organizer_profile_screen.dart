import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrganizerProfileScreen extends StatefulWidget {
  const OrganizerProfileScreen({super.key});

  @override
  State<OrganizerProfileScreen> createState() => _OrganizerProfileScreenState();
}

class _MenuItem {
  final String label;
  final IconData icon;
  final bool isDestructive;
  const _MenuItem(this.label, this.icon, {this.isDestructive = false});
}

class _OrganizerProfileScreenState extends State<OrganizerProfileScreen> {
  static const String _name = 'Amara Kone';
  static const String _initials = 'AK';
  static const String _tier = 'Platinum Organizer';
  static const String _bio =
      'Community builder & event strategist at ALU. '
      'Running 3 active communities focused on Tech, Entrepreneurship & Leadership.';

  static const List<String> _focus = [
    'Entrepreneurship',
    'Artificial Intelligence',
    'Leadership',
    'Community Building',
    'Public Speaking',
  ];

  static const List<_MenuItem> _menu = [
    _MenuItem('My Posts', Icons.post_add_outlined),
    _MenuItem('Analytics', Icons.bar_chart_outlined),
    _MenuItem('Co-organizers', Icons.group_outlined),
    _MenuItem('Payout & Earnings', Icons.account_balance_wallet_outlined),
    _MenuItem('Settings', Icons.settings_outlined),
    _MenuItem('Log Out', Icons.logout, isDestructive: true),
  ];

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _confirmLogout() async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to sign in again to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        titleSpacing: 16,
        title: const Text(
          'My Profile',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.white),
            onPressed: () => _toast('Notifications (demo)'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navy,
        currentIndex: 3,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: Colors.white.withOpacity(0.55),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/organizer-dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/organizer-posts');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/organizer-communities');
              break;
            case 3:
              break; // already here
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Post'),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups_rounded), label: 'Community'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          _header(),
          Transform.translate(
            offset: const Offset(0, -28),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _statsCard(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: _focusSection(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _menuCard(),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 44),
      child: Column(
        children: [
          // Avatar with platinum ring
          SizedBox(
            width: 96,
            height: 96,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold,
                  ),
                  child: const CircleAvatar(
                    radius: 42,
                    backgroundColor: Color(0xFF1B2A45),
                    child: Text(
                      _initials,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                // Platinum badge
                Positioned(
                  bottom: -6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.navy, width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.star, size: 11, color: AppColors.navy),
                        SizedBox(width: 3),
                        Text(
                          'PLATINUM',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            _name,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.white),
          ),
          const SizedBox(height: 4),
          Text(
            _tier,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gold.withOpacity(0.9),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _bio,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: AppColors.white.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatTile(value: '24', label: 'Posts'),
          _divider(),
          _StatTile(value: '1.2k', label: 'RSVPs'),
          _divider(),
          _StatTile(value: '4.9★', label: 'Rating'),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(width: 1, height: 34, color: AppColors.divider);

  Widget _focusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Focus Areas',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _focus
              .map(
                (tag) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderGrey),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _menuCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          for (int i = 0; i < _menu.length; i++) ...[
            _MenuRow(
              item: _menu[i],
              onTap: () {
                if (_menu[i].isDestructive) {
                  _confirmLogout();
                } else if (_menu[i].label == 'My Posts') {
                  Navigator.pushReplacementNamed(context, '/organizer-posts');
                } else {
                  _toast('${_menu[i].label} (demo)');
                }
              },
            ),
            if (i != _menu.length - 1) const Divider(height: 1, indent: 64),
          ],
        ],
      ),
    );
  }
}

// ─── Shared sub-widgets ───────────────────────────────────────────────────────

class _StatTile extends StatelessWidget {
  final String value;
  final String label;
  const _StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.navy),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
      ],
    );
  }
}

class _MenuRow extends StatelessWidget {
  final _MenuItem item;
  final VoidCallback onTap;
  const _MenuRow({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color fg = item.isDestructive ? AppColors.error : AppColors.navy;
    final Color textColor =
        item.isDestructive ? AppColors.error : AppColors.textDark;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: item.isDestructive
                    ? AppColors.error.withOpacity(0.08)
                    : AppColors.inputGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, size: 20, color: fg),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
            Icon(Icons.chevron_right,
                size: 20,
                color: item.isDestructive
                    ? AppColors.error
                    : AppColors.borderGrey),
          ],
        ),
      ),
    );
  }
}