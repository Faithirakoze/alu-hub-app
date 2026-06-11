// group_chat_screen.dart
// The group chat screen — shows messages between community members.
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/chat_bubble.dart';
import '../models/mock_data.dart';

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

      body: Column(
        children: [

          // ── MESSAGE LIST ────────────────────────────────────────────────────
          Expanded(
            // ListView.builder: only builds the widgets that are visible on screen.
            // More efficient than ListView with a fixed children list.
            child: ListView.builder(
              // reverse: true makes the list start from the bottom (newest messages at bottom)
              // and scroll upward — this is standard for chat apps.
              reverse: false,
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              itemCount: mockChatMessages.length + 1, // +1 for the "Today" divider
              itemBuilder: (context, index) {
                // Show the date divider in the middle of the list (after index 2)
                if (index == 3) {
                  return _buildDateDivider('Today');
                }
                // Offset the index by 1 after the divider
                final messageIndex = index > 3 ? index - 1 : index;
                return ChatBubble(message: mockChatMessages[messageIndex]);
              },
            ),
          ),

          // ── MESSAGE INPUT BAR ────────────────────────────────────────────────
          _buildMessageInput(),
        ],
      ),
    );
  }

  // _buildDateDivider: the "Today" label that separates older and newer messages.
  Widget _buildDateDivider(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          // Expanded + Divider fills the space to the left of the label
          const Expanded(child: Divider(color: Color(0xFFC5C6CE))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEFEDF0),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const Expanded(child: Divider(color: Color(0xFFC5C6CE))),
        ],
      ),
    );
  }

  // _buildMessageInput: the bar at the bottom with the text field and send button.
  Widget _buildMessageInput() {
    // _messageController reads and clears the text field
    final controller = TextEditingController();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [

          // + button for attachments
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.onSurfaceVariant),
            onPressed: () {},
          ),

          // Text field — Expanded fills remaining space between the two buttons
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: AppColors.onSurfaceVariant),
                filled: true,
                fillColor: const Color(0xFFEFEDF0),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24), // pill shape
                  borderSide: BorderSide.none, // no visible border line
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button — gold circle
          GestureDetector(
            onTap: () {
              // send logic should come here
              controller.clear();
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),

        ],
      ),
    );
  }
}