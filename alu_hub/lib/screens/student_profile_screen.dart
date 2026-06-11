import 'package:flutter/material.dart';
import '../theme/app_theme.dart';


class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _MenuItem {
  final String label;
  final IconData icon;
  final bool isDestructive; // true => styled in red (e.g. Log Out)
  const _MenuItem(this.label, this.icon, {this.isDestructive = false});
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {

  static const String _name = 'Kelechi Okafor';
  static const String _initials = 'KO';
  static const int _level = 12;
  static const String _bio =
      'Aspiring Software Engineer & Tech Community Lead. '
      'Passionate about AI for social good in Kigali.';

  static const List<String> _interests = [
    'Artificial Intelligence',
    'FinTech',
    'Public Speaking',
    'Robotics',
    'Entrepreneurship',
  ];

  static const List<_MenuItem> _menu = [
    _MenuItem('RSVPs', Icons.event_available_outlined),
    _MenuItem('Saved Resources', Icons.bookmark_border),
    _MenuItem('Badges', Icons.workspace_premium_outlined),
    _MenuItem('Mentorship', Icons.school_outlined),
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
        titleSpacing: 16,
        title: Row(
          children: const [
            Icon(Icons.school, color: AppColors.gold, size: 22),
            SizedBox(width: 8),
            Text('ALU Hub',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => _toast('Notifications (demo)'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navy,
        currentIndex: 4,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: Colors.white.withOpacity(0.55),
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
            case 4:
              break; // already here
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
            child: _interestsSection(),
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
                        SizedBox(width: 2),
                        Text('$_level',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.navy)),
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
          const SizedBox(height: 8),
          Text(
            _bio,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: AppColors.white.withValues(alpha: 0.75),
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
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatTile(value: '24', label: 'Events'),
          _divider(),
          _StatTile(value: '8', label: 'Communities'),
          _divider(),
          _StatTile(value: '15', label: 'Saved'),
        ],
      ),
    );
  }

  Widget _divider() =>
      Container(width: 1, height: 34, color: AppColors.divider);

  Widget _interestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Interests',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _interests
              .map((tag) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderGrey),
                    ),
                    child: Text(tag,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark)),
                  ))
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
                } else {
                  _toast('${_menu[i].label} (demo)');
                }
              },
            ),
            if (i != _menu.length - 1)
              const Divider(height: 1, indent: 64),
          ],
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String value;
  final String label;
  const _StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.navy)),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
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
                    ? AppColors.error.withValues(alpha: 0.08)
                    : AppColors.inputGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, size: 20, color: fg),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(item.label,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textColor)),
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