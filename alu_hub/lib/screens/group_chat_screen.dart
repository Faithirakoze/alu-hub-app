// group_chat_screen.dart
// The group chat screen — shows messages between community members.
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GroupChatScreen extends StatefulWidget {
  // groupName: passed in from the community list so the AppBar shows the right title
  final String groupName;
  const GroupChatScreen({super.key, required this.groupName});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F5), // light grey page background

      // ── APP BAR ──────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.navy,

        // leading: the back arrow on the left.
        // Navigator.pop(context) closes this screen and goes back to the previous one.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        // title: avatar + group name + members online
        title: Row(
          children: [
            // Small circular avatar for the group
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.gold.withOpacity(0.3),
              child: const Icon(Icons.groups, color: AppColors.gold, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // widget.groupName accesses the groupName field from the StatefulWidget
                Text(
                  widget.groupName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                // Members online indicator
                Row(
                  children: [
                    // Green dot = online indicator
                    Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50), // green
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '12 Members Online',
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // actions: buttons on the right of the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: Colors.white),
            onPressed: () {}, // placeholder
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {}, // placeholder
          ),
        ],
      ),

      body: const Center(child: Text('Messages coming soon')),
    );
  }
}