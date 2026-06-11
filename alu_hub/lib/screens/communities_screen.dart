import 'package:flutter/material.dart';
import '../models/mock_data.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _communities = [
    {'name': 'ALU Software Engineering', 'members': '1,260', 'icon': Icons.code, 'color': const Color(0xFF1B2B4B), 'isJoined': true},
    {'name': 'ALU Entrepreneurs Hub', 'members': '843', 'icon': Icons.lightbulb_outline, 'color': const Color(0xFF1B2B4B), 'isJoined': false},
    {'name': 'Student Wellness Circle', 'members': '512', 'icon': Icons.self_improvement, 'color': const Color(0xFF1B2B4B), 'isJoined': true},
    {'name': 'ALU Finance & Grants', 'members': '390', 'icon': Icons.account_balance_outlined, 'color': const Color(0xFF1B2B4B), 'isJoined': false},
  ];

  int _activeCommunityIndex = 0;
  bool _isInCommunity = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: communityTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isInCommunity) {
      return _buildCommunityDetail();
    }
    return _buildCommunityList();
  }
  Widget _buildCommunityList() {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Communities', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0B1B3D), 
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Your Communities',
            style: TextStyle(color: Color(0xFF0B1B3D), fontSize: 18, fontWeight: FontWeight.bold), 
          ),
          const SizedBox(height: 12),
          ..._communities
              .where((c) => c['isJoined'] == true)
              .map((c) => _CommunityListTile(
                    community: c,
                    onTap: () {
                      setState(() {
                        _activeCommunityIndex = _communities.indexOf(c);
                        _isInCommunity = true;
                      });
                    },
                  )),
          const SizedBox(height: 24),
          const Text(
            'Discover Communities',
            style: TextStyle(color: Color(0xFF0B1B3D), fontSize: 18, fontWeight: FontWeight.bold), 
          ),
          const SizedBox(height: 12),
          ..._communities
              .where((c) => c['isJoined'] == false)
              .map((c) => _CommunityListTile(
                    community: c,
                    onTap: () {
                      setState(() {
                        _activeCommunityIndex = _communities.indexOf(c);
                        _isInCommunity = true;
                      });
                    },
                    showJoinButton: true,
                    onJoin: () => setState(() => c['isJoined'] = true),
                  )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0B1B3D),
      currentIndex: 2, // Communities is index 2
      selectedItemColor: const Color(0xFFF5A623),
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
            break; 
          case 3:
            Navigator.pushReplacementNamed(context, '/passport');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile');
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

  Widget _buildCommunityDetail() {
    final community = _communities[_activeCommunityIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), 
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1B3D), 
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => setState(() => _isInCommunity = false),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              community['name'],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              '${community['members']} Members',
              style: const TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFF5A623),
          labelColor: const Color(0xFFF5A623),
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: communityTabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: communityTabs.map((tab) => _PostList(tab: tab)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0B1B3D), 
        foregroundColor: Colors.white,
        onPressed: () => _showPostDialog(context),
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _showPostDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0B1B3D),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('New Post', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Share something with the community...',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1B2B4B),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5A623),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  final String tab;
  const _PostList({required this.tab});

  @override
  Widget build(BuildContext context) {
    final posts = mockCommunityPosts.where((p) => p.tab == tab).toList();
    if (posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inbox_outlined, color: Colors.black26, size: 48),
            const SizedBox(height: 8),
            Text('No $tab yet', style: const TextStyle(color: Colors.black38)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemCount: posts.length,
      itemBuilder: (_, i) => _PostCard(post: posts[i]),
    );
  }
}

class _PostCard extends StatefulWidget {
  final CommunityPost post;
  const _PostCard({required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  late int _likes;
  bool _liked = false;

  @override
  void initState() {
    super.initState();
    _likes = widget.post.likes;
  }

  Color get _roleColor {
    switch (widget.post.authorRole) {
      case 'ADMIN':   return const Color(0xFFF5A623);
      case 'FACULTY': return const Color(0xFF4A90D9);
      default:        return Colors.black54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: widget.post.isPinned
            ? Border.all(color: const Color(0xFFF5A623).withOpacity(0.4))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: _roleColor.withOpacity(0.1),
                child: Text(
                  widget.post.authorName[0],
                  style: TextStyle(color: _roleColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.post.authorName,
                          style: const TextStyle(color: Color(0xFF0B1B3D), fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        const SizedBox(width: 6),
                        if (widget.post.authorRole != 'STUDENT')
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: _roleColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              widget.post.authorRole,
                              style: TextStyle(color: _roleColor, fontSize: 9, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    if (widget.post.timeAgo.isNotEmpty)
                      Text(widget.post.timeAgo, style: const TextStyle(color: Colors.black38, fontSize: 11)),
                  ],
                ),
              ),
              if (widget.post.isPinned)
                const Icon(Icons.push_pin, color: Color(0xFFF5A623), size: 16),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.post.content,
            style: const TextStyle(color: Color(0xFF2C3E50), fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _liked = !_liked;
                  _likes += _liked ? 1 : -1;
                }),
                child: Row(
                  children: [
                    Icon(
                      _liked ? Icons.favorite : Icons.favorite_border,
                      color: _liked ? Colors.redAccent : Colors.black38,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$_likes',
                      style: TextStyle(
                        color: _liked ? Colors.redAccent : Colors.black38,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  const Icon(Icons.chat_bubble_outline, color: Colors.black38, size: 18),
                  const SizedBox(width: 4),
                  Text('${widget.post.comments}', style: const TextStyle(color: Colors.black38, fontSize: 13)),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.share_outlined, color: Colors.black38, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommunityListTile extends StatelessWidget {
  final Map<String, dynamic> community;
  final VoidCallback onTap;
  final bool showJoinButton;
  final VoidCallback? onJoin;

  const _CommunityListTile({
    required this.community,
    required this.onTap,
    this.showJoinButton = false,
    this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, // Matches the bright resource container cards in Pic 1
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFFF4F6F8), // Soft neutral icon background
              child: Icon(community['icon'] as IconData, color: const Color(0xFF0B1B3D)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community['name'],
                    style: const TextStyle(color: Color(0xFF0B1B3D), fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${community['members']} members',
                    style: const TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (showJoinButton)
              OutlinedButton(
                onPressed: onJoin,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0B1B3D),
                  side: const BorderSide(color: Color(0xFF0B1B3D), width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Rounded outline style
                ),
                child: const Text('Join', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              )
            else
              const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}