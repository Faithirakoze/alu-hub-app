import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ─── Data models ────────────────────────────────────────────────────────────

enum MemberRole { member, coOrganizer, moderator }

enum MemberStatus { active, new_, atRisk }

class CommunityMember {
  final String id;
  final String name;
  final String initials;
  final MemberRole role;
  final MemberStatus status;
  final int postCount;
  final int attendancePct;
  final String joinedLabel; // e.g. "Joined 3 days ago"

  const CommunityMember({
    required this.id,
    required this.name,
    required this.initials,
    required this.role,
    required this.status,
    required this.postCount,
    required this.attendancePct,
    required this.joinedLabel,
  });
}

class CommunityActivity {
  final String description; // e.g. "Amara RSVPed to …"
  final String timeLabel;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const CommunityActivity({
    required this.description,
    required this.timeLabel,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });
}

// ─── Mock data ───────────────────────────────────────────────────────────────

final List<CommunityMember> mockCommunityMembers = [
  const CommunityMember(
    id: '1',
    name: 'Amara Kone',
    initials: 'AK',
    role: MemberRole.member,
    status: MemberStatus.active,
    postCount: 12,
    attendancePct: 94,
    joinedLabel: 'Member since Jan 2025',
  ),
  const CommunityMember(
    id: '2',
    name: 'Brian Nziza',
    initials: 'BN',
    role: MemberRole.member,
    status: MemberStatus.new_,
    postCount: 1,
    attendancePct: 100,
    joinedLabel: 'Joined 3 days ago',
  ),
  const CommunityMember(
    id: '3',
    name: 'James Okonkwo',
    initials: 'JO',
    role: MemberRole.coOrganizer,
    status: MemberStatus.active,
    postCount: 22,
    attendancePct: 88,
    joinedLabel: 'Member since Sep 2024',
  ),
  const CommunityMember(
    id: '4',
    name: 'Lena Mugisha',
    initials: 'LM',
    role: MemberRole.member,
    status: MemberStatus.atRisk,
    postCount: 3,
    attendancePct: 42,
    joinedLabel: 'Member since Mar 2025',
  ),
  const CommunityMember(
    id: '5',
    name: 'Claudette Iradukunda',
    initials: 'CI',
    role: MemberRole.moderator,
    status: MemberStatus.active,
    postCount: 9,
    attendancePct: 79,
    joinedLabel: 'Member since Nov 2024',
  ),
  const CommunityMember(
    id: '6',
    name: 'Felix Andela',
    initials: 'FA',
    role: MemberRole.member,
    status: MemberStatus.new_,
    postCount: 0,
    attendancePct: 0,
    joinedLabel: 'Joined today',
  ),
];

final List<CommunityActivity> mockCommunityActivity = [
  CommunityActivity(
    description: 'Amara Kone RSVPed to "Data Bootcamp Vol. 3"',
    timeLabel: '2 hours ago',
    icon: Icons.calendar_today_outlined,
    iconBg: const Color(0xFFFFF3DC),
    iconColor: AppColors.gold,
  ),
  CommunityActivity(
    description: 'Brian Nziza joined the community',
    timeLabel: '3 hours ago',
    icon: Icons.person_add_outlined,
    iconBg: const Color(0xFFE1F5EE),
    iconColor: Color(0xFF0F6E56),
  ),
  CommunityActivity(
    description: 'Lena Mugisha commented on your post',
    timeLabel: 'Yesterday',
    icon: Icons.chat_bubble_outline,
    iconBg: const Color(0xFFE6F1FB),
    iconColor: Color(0xFF185FA5),
  ),
  CommunityActivity(
    description: 'James Okonkwo published "Career Fair 2025"',
    timeLabel: 'Yesterday',
    icon: Icons.post_add_outlined,
    iconBg: const Color(0xFFEEEDFE),
    iconColor: Color(0xFF3C3489),
  ),
  CommunityActivity(
    description: 'Felix Andela joined the community',
    timeLabel: '2 days ago',
    icon: Icons.person_add_outlined,
    iconBg: const Color(0xFFE1F5EE),
    iconColor: Color(0xFF0F6E56),
  ),
];

// Pending join requests (subset of members flagged as new_ for demo)
final List<CommunityMember> mockPendingRequests = [
  const CommunityMember(
    id: '7',
    name: 'Solange Uwera',
    initials: 'SU',
    role: MemberRole.member,
    status: MemberStatus.new_,
    postCount: 0,
    attendancePct: 0,
    joinedLabel: 'Requested 1 hour ago',
  ),
  const CommunityMember(
    id: '8',
    name: 'Patrick Habimana',
    initials: 'PH',
    role: MemberRole.member,
    status: MemberStatus.new_,
    postCount: 0,
    attendancePct: 0,
    joinedLabel: 'Requested 4 hours ago',
  ),
  const CommunityMember(
    id: '9',
    name: 'Grace Ineza',
    initials: 'GI',
    role: MemberRole.member,
    status: MemberStatus.new_,
    postCount: 0,
    attendancePct: 0,
    joinedLabel: 'Requested yesterday',
  ),
];

// ─── Screen ──────────────────────────────────────────────────────────────────

class OrganizerCommunityScreen extends StatefulWidget {
  const OrganizerCommunityScreen({super.key});

  @override
  State<OrganizerCommunityScreen> createState() =>
      _OrganizerCommunityScreenState();
}

class _OrganizerCommunityScreenState extends State<OrganizerCommunityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<String> _memberFilters = [
    'All',
    'New',
    'Most active',
    'Organizers',
    'At risk',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  List<CommunityMember> get _filteredMembers {
    return mockCommunityMembers.where((m) {
      final matchesSearch = _searchQuery.isEmpty ||
          m.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = switch (_selectedFilter) {
        'New' => m.status == MemberStatus.new_,
        'Most active' => m.postCount >= 8,
        'Organizers' =>
          m.role == MemberRole.coOrganizer ||
              m.role == MemberRole.moderator,
        'At risk' => m.status == MemberStatus.atRisk,
        _ => true,
      };
      return matchesSearch && matchesFilter;
    }).toList();
  }

  // ── Avatar colour cycling ─────────────────────────────────────────────────
  static const List<Color> _avatarBgs = [
    Color(0xFFD7E2FF),
    Color(0xFFE1F5EE),
    Color(0xFFFAECE7),
    Color(0xFFEEEDFE),
    Color(0xFFFFF3DC),
  ];
  static const List<Color> _avatarFgs = [
    Color(0xFF1A3A6B),
    Color(0xFF085041),
    Color(0xFF712B13),
    Color(0xFF3C3489),
    Color(0xFF633806),
  ];

  Color _avatarBg(int index) => _avatarBgs[index % _avatarBgs.length];
  Color _avatarFg(int index) => _avatarFgs[index % _avatarFgs.length];

  // ── Widgets ───────────────────────────────────────────────────────────────

  Widget _buildAvatar(String initials, int colorIndex) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _avatarBg(colorIndex),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: _avatarFg(colorIndex),
        ),
      ),
    );
  }

  Widget _buildRoleBadge(MemberRole role) {
    if (role == MemberRole.member) return const SizedBox.shrink();
    final label = role == MemberRole.coOrganizer ? 'Co-organizer' : 'Mod';
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.navy.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.navy,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(MemberStatus status) {
    if (status == MemberStatus.active) return const SizedBox.shrink();
    final isNew = status == MemberStatus.new_;
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isNew
            ? const Color(0xFFEAF3DE)
            : const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isNew ? 'New' : 'At risk',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isNew
              ? const Color(0xFF27500A)
              : const Color(0xFFA32D2D),
        ),
      ),
    );
  }

  // ── Overview tab ──────────────────────────────────────────────────────────

  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        // Stat cards — 2×2 grid
        _SectionLabel(label: 'Community snapshot'),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.55,
          children: const [
            _StatCard(label: 'Total members', value: '348', delta: '+12'),
            _StatCard(label: 'Active this week', value: '91', delta: '↑ 26%'),
            _StatCard(label: 'Pending requests', value: '7', delta: null),
            _StatCard(label: 'Avg engagement', value: '74%', delta: null),
          ],
        ),
        const SizedBox(height: 24),

        // Recent activity
        _SectionLabel(label: 'Recent activity'),
        const SizedBox(height: 10),
        ...mockCommunityActivity.map((a) => _ActivityCard(activity: a)),
      ],
    );
  }

  // ── Members tab ───────────────────────────────────────────────────────────

  Widget _buildMembersTab() {
    final members = _filteredMembers;
    return Column(
      children: [
        // Filter chips
        Container(
          height: 52,
          color: AppColors.background,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: _memberFilters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final f = _memberFilters[i];
              final selected = _selectedFilter == f;
              return GestureDetector(
                onTap: () => setState(() => _selectedFilter = f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.gold : AppColors.white,
                    border: Border.all(
                      color: selected
                          ? AppColors.gold
                          : AppColors.borderGrey,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    f,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selected ? AppColors.navy : AppColors.textGrey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Count label
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${members.length} member${members.length == 1 ? '' : 's'}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // List
        Expanded(
          child: members.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_search_outlined,
                          size: 48, color: AppColors.borderGrey),
                      SizedBox(height: 12),
                      Text(
                        'No members found',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textGrey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Try a different filter or search.',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.borderGrey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  itemCount: members.length,
                  itemBuilder: (_, i) {
                    final m = members[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _MemberCard(
                        member: m,
                        colorIndex: i,
                        onTap: () => _toast('${m.name} profile (demo)'),
                        onMessage: () =>
                            _toast('Message ${m.name} (demo)'),
                        avatarBg: _avatarBg(i),
                        avatarFg: _avatarFg(i),
                        roleBadge: _buildRoleBadge(m.role),
                        statusBadge: _buildStatusBadge(m.status),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ── Activity tab ──────────────────────────────────────────────────────────

  Widget _buildActivityTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _SectionLabel(label: 'All activity'),
        const SizedBox(height: 10),
        ...mockCommunityActivity.map((a) => _ActivityCard(activity: a)),
        ...mockCommunityActivity.map((a) => _ActivityCard(activity: a)),
      ],
    );
  }

  // ── Requests tab ──────────────────────────────────────────────────────────

  Widget _buildRequestsTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _SectionLabel(
            label: '${mockPendingRequests.length} pending requests'),
        const SizedBox(height: 10),
        ...mockPendingRequests.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _RequestCard(
                  member: e.value,
                  avatarBg: _avatarBg(e.key),
                  avatarFg: _avatarFg(e.key),
                  onApprove: () =>
                      _toast('${e.value.name} approved (demo)'),
                  onDecline: () =>
                      _toast('${e.value.name} declined (demo)'),
                ),
              ),
            ),
      ],
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        titleSpacing: 16,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Community',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white),
            ),
            Text(
              '★ PLATINUM ORGANIZER',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gold,
                  letterSpacing: 0.5),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.white),
            onPressed: () => _toast('Notifications (demo)'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: AppColors.white),
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Search members or posts...',
                    hintStyle:
                        TextStyle(color: AppColors.white.withOpacity(0.55)),
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.white, size: 20),
                    filled: true,
                    fillColor: AppColors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              // Tabs
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.gold,
                indicatorWeight: 2.5,
                labelColor: AppColors.white,
                unselectedLabelColor:
                    AppColors.white.withOpacity(0.55),
                labelStyle: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Members'),
                  Tab(text: 'Activity'),
                  Tab(text: 'Requests'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navy,
        currentIndex: 2, // Community is index 2
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildMembersTab(),
          _buildActivityTab(),
          _buildRequestsTab(),
        ],
      ),
    );
  }
}

// ─── Reusable sub-widgets ────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.textGrey,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? delta;

  const _StatCard({
    required this.label,
    required this.value,
    this.delta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              if (delta != null) ...[
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    delta!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final CommunityActivity activity;
  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderGrey.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: activity.iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(activity.icon, size: 18, color: activity.iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  activity.timeLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final CommunityMember member;
  final int colorIndex;
  final Color avatarBg;
  final Color avatarFg;
  final Widget roleBadge;
  final Widget statusBadge;
  final VoidCallback onTap;
  final VoidCallback onMessage;

  const _MemberCard({
    required this.member,
    required this.colorIndex,
    required this.avatarBg,
    required this.avatarFg,
    required this.roleBadge,
    required this.statusBadge,
    required this.onTap,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderGrey.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: avatarBg, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(
                member.initials,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: avatarFg,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          member.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      roleBadge,
                      statusBadge,
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    member.status == MemberStatus.new_
                        ? member.joinedLabel
                        : '${member.postCount} posts · ${member.attendancePct}% attendance',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Message icon
            GestureDetector(
              onTap: onMessage,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.inputGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  size: 16,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final CommunityMember member;
  final Color avatarBg;
  final Color avatarFg;
  final VoidCallback onApprove;
  final VoidCallback onDecline;

  const _RequestCard({
    required this.member,
    required this.avatarBg,
    required this.avatarFg,
    required this.onApprove,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGrey.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration:
                    BoxDecoration(color: avatarBg, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  member.initials,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: avatarFg,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      member.joinedLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textGrey,
                    side: const BorderSide(color: AppColors.borderGrey),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Decline',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onApprove,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.navy,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Approve',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}