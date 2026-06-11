import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum PostTab { active, past, review }

enum PostCategory { academic, social }

enum PostStatus { live, draft, completed }

class OrganizerPost {
  final String title;
  final String dateLabel;
  final PostCategory category;
  final PostStatus status;
  final PostTab tab;
  final int views;
  final String rsvps;
  final String attended;
  final String progressLabel;
  final double progress;
  final String primaryAction;
  final String secondaryAction;

  const OrganizerPost({
    required this.title,
    required this.dateLabel,
    required this.category,
    required this.status,
    required this.tab,
    required this.views,
    required this.rsvps,
    required this.attended,
    required this.progressLabel,
    required this.progress,
    required this.primaryAction,
    required this.secondaryAction,
  });
}

const List<OrganizerPost> mockOrganizerPosts = [
  OrganizerPost(
    title: 'AI Governance Summit 2024',
    dateLabel: 'Oct 24, 2024 • 10:00 AM',
    category: PostCategory.academic,
    status: PostStatus.live,
    tab: PostTab.active,
    views: 842,
    rsvps: '156',
    attended: '42',
    progressLabel: 'Capacity Goal',
    progress: 0.78,
    primaryAction: 'Edit Details',
    secondaryAction: 'Cross-post',
  ),
  OrganizerPost(
    title: 'Mauritius Cultural Night',
    dateLabel: 'Nov 12, 2024 • 06:30 PM',
    category: PostCategory.social,
    status: PostStatus.draft,
    tab: PostTab.active,
    views: 12,
    rsvps: '0',
    attended: '-',
    progressLabel: 'Setup Progress',
    progress: 0.20,
    primaryAction: 'Finish Draft',
    secondaryAction: 'Preview',
  ),
  OrganizerPost(
    title: 'Founders Friday Mixer',
    dateLabel: 'Sep 06, 2024 • 05:00 PM',
    category: PostCategory.social,
    status: PostStatus.completed,
    tab: PostTab.past,
    views: 510,
    rsvps: '98',
    attended: '76',
    progressLabel: 'Final Attendance',
    progress: 0.92,
    primaryAction: 'View Report',
    secondaryAction: 'Duplicate',
  ),
];

class OrganizerDashboardScreen extends StatefulWidget {
  const OrganizerDashboardScreen({super.key});

  @override
  State<OrganizerDashboardScreen> createState() =>
      _OrganizerDashboardScreenState();
}

class _OrganizerDashboardScreenState extends State<OrganizerDashboardScreen> {
  PostTab _selectedTab = PostTab.active;
  int _currentNavIndex = 0;

  static const Color _academicBg = Color(0xFFD7E2FF);
  static const Color _socialBg = Color(0xFFFFDCBF);
  static const Color _socialText = Color(0xFF5E4023);
  static const Color _deltaColor = Color(0xFF835500);

  List<OrganizerPost> get _visiblePosts =>
    mockOrganizerPosts.where((p) => p.tab == _selectedTab).toList();

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final posts = _visiblePosts;

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.navy,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () => _toast('New post (demo)'),
        child: const Icon(Icons.add, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navy,
        currentIndex: _currentNavIndex,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: Colors.white.withOpacity(0.55),
        onTap: (index) {
          setState(() => _currentNavIndex = index);
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/organizer-post');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/organizer-communities');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/organizer-profile');
              break;
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          _statsGrid(),
          const SizedBox(height: 20),
          _tabBar(),
          const SizedBox(height: 16),
          if (posts.isEmpty)
            const _EmptyPosts()
          else
            ...posts.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OrganizerPostCard(
                    post: p,
                    academicBg: _academicBg,
                    socialBg: _socialBg,
                    socialText: _socialText,
                    onAction: _toast,
                  ),
                )),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold,
            ),
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.navy,
              child: Icon(Icons.person, color: AppColors.white, size: 20),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('My Dashboard',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white)),
              Row(
                children: const [
                  Icon(Icons.star, size: 12, color: AppColors.gold),
                  SizedBox(width: 4),
                  Text('PLATINUM ORGANIZER',
                      style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gold)),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () => _toast('Notifications (demo)'),
        ),
      ],
    );
  }

  Widget _statsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.9,
      children: [
        _StatCard(
            label: 'Total Posts',
            value: '24',
            trailing: const Text('+2',
                style: TextStyle(
                    color: _deltaColor, fontWeight: FontWeight.w600))),
        _StatCard(
            label: 'Total RSVPs',
            value: '1.2k',
            trailing: const Text('+15%',
                style: TextStyle(
                    color: _deltaColor, fontWeight: FontWeight.w600))),
        _StatCard(
            label: 'Attendance',
            value: '88%',
            trailing: const Icon(Icons.trending_up,
                size: 18, color: _deltaColor)),
        _StatCard(
            label: 'Rating',
            value: '4.9',
            trailing:
                const Icon(Icons.star, size: 18, color: AppColors.gold)),
      ],
    );
  }

  Widget _tabBar() {
    Widget tab(String label, PostTab value) {
      final bool selected = _selectedTab == value;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _selectedTab = value),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ? AppColors.navy : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.navy : AppColors.textGrey,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          tab('Active Posts', PostTab.active),
          tab('Past Posts', PostTab.past),
          tab('Under Review', PostTab.review),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Widget trailing;

  const _StatCard({
    required this.label,
    required this.value,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navy)),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: trailing,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrganizerPostCard extends StatelessWidget {
  final OrganizerPost post;
  final Color academicBg;
  final Color socialBg;
  final Color socialText;
  final void Function(String) onAction;

  const OrganizerPostCard({
    required this.post,
    required this.academicBg,
    required this.socialBg,
    required this.socialText,
    required this.onAction,
  });

  bool get _isAcademic => post.category == PostCategory.academic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderGrey.withValues(alpha: 0.4)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _categoryBadge(),
                          const SizedBox(height: 6),
                          Text(post.title,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.navy)),
                        ],
                      ),
                    ),
                    _statusChip(),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: AppColors.textGrey),
                    const SizedBox(width: 6),
                    Text(post.dateLabel,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.textGrey)),
                  ],
                ),
                const SizedBox(height: 12),
                _metricsRow(),
                const SizedBox(height: 12),
                _progress(),
              ],
            ),
          ),
          const Divider(height: 1),
          _actionButtons(),
        ],
      ),
    );
  }

  Widget _categoryBadge() {
    final Color bg = _isAcademic ? academicBg : socialBg;
    final Color fg = _isAcademic ? AppColors.navy : socialText;
    final String text = _isAcademic ? 'ACADEMIC' : 'SOCIAL';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );
  }

  Widget _statusChip() {
    late Color bg;
    late Color fg;
    late String label;
    switch (post.status) {
      case PostStatus.live:
        bg = AppColors.gold.withValues(alpha: 0.18);
        fg = const Color(0xFF835500);
        label = 'LIVE';
        break;
      case PostStatus.draft:
        bg = AppColors.inputGrey;
        fg = AppColors.textGrey;
        label = 'DRAFT';
        break;
      case PostStatus.completed:
        bg = AppColors.finance.withValues(alpha: 0.15);
        fg = AppColors.finance;
        label = 'DONE';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );
  }

  Widget _metricsRow() {
    Widget metric(String label, String value, {bool bordered = false}) {
      return Expanded(
        child: Container(
          decoration: bordered
              ? const BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(color: AppColors.divider),
                  ),
                )
              : null,
          child: Column(
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGrey)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy)),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.divider),
        ),
      ),
      child: Row(
        children: [
          metric('Views', '${post.views}'),
          metric('RSVPs', post.rsvps, bordered: true),
          metric('Attended', post.attended),
        ],
      ),
    );
  }

  Widget _progress() {
    final Color barColor =
        post.status == PostStatus.draft ? AppColors.borderGrey : AppColors.gold;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(post.progressLabel,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGrey)),
            Text('${(post.progress * 100).round()}%',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGrey)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: post.progress,
            minHeight: 8,
            backgroundColor: AppColors.inputGrey,
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }

  Widget _actionButtons() {
    Widget button(String label, {bool bordered = false}) {
      return Expanded(
        child: InkWell(
          onTap: () => onAction('$label (demo)'),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: bordered
                ? const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.divider),
                    ),
                  )
                : null,
            alignment: Alignment.center,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy)),
          ),
        ),
      );
    }

    return Row(
      children: [
        button(post.primaryAction, bordered: true),
        button(post.secondaryAction),
      ],
    );
  }
}

class _EmptyPosts extends StatelessWidget {
  const _EmptyPosts();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: const [
          Icon(Icons.inbox_outlined, size: 48, color: AppColors.borderGrey),
          SizedBox(height: 12),
          Text('Nothing here yet',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey)),
          SizedBox(height: 4),
          Text('Posts in this category will appear here.',
              style: TextStyle(fontSize: 13, color: AppColors.borderGrey)),
        ],
      ),
    );
  }
}