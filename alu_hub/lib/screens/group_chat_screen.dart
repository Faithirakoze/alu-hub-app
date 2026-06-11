// group_chat_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/chat_bubble.dart';
import '../models/mock_data.dart';

class GroupChatScreen extends StatefulWidget {
  final String groupName;
  const GroupChatScreen({super.key, required this.groupName});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  // TextEditingController reads and clears the message input field
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    // Always dispose controllers to free memory
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F5),

      // ── APP BAR ────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        // titleSpacing 0 removes default padding so we control spacing ourselves
        titleSpacing: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        // FIX: wrap the title Row in Flexible so it can shrink when space is tight
        title: Row(
          children: [
            // Small group avatar circle
            CircleAvatar(
              radius: 16, // reduced from 18 to save space
              backgroundColor: AppColors.gold.withOpacity(0.3),
              child: const Icon(Icons.groups, color: AppColors.gold, size: 18),
            ),
            const SizedBox(width: 8),

            // FIX: Flexible allows this Column to shrink if the Row runs out of space
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // widget.groupName accesses the field from the StatefulWidget
                  Text(
                    widget.groupName,
                    style: const TextStyle(
                      fontSize: 14, // reduced from 15 to prevent overflow
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    // overflow ellipsis cuts off text with "..." if still too long
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Green online indicator dot
                      Container(
                        width: 7, height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '12 Members Online',
                        style: TextStyle(fontSize: 10, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      // ── BODY ────────────────────────────────────────────────────────────
      body: Column(
        children: [

          // Message list — Expanded fills all space above the input bar
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              // +1 for the "Today" date divider
              itemCount: mockChatMessages.length + 1,
              itemBuilder: (context, index) {
                // Show date divider after the 3rd message (index 3)
                if (index == 3) return _buildDateDivider('Today');
                // Offset index by 1 after the divider position
                final msgIndex = index > 3 ? index - 1 : index;
                return ChatBubble(message: mockChatMessages[msgIndex]);
              },
            ),
          ),

          // Message input bar pinned at the bottom
          _buildMessageInput(),
        ],
      ),
    );
  }

  // ── DATE DIVIDER ────────────────────────────────────────────────────────
  // The "Today" pill label that separates older and newer messages
  Widget _buildDateDivider(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          // Line to the left of the label
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
          // Line to the right of the label
          const Expanded(child: Divider(color: Color(0xFFC5C6CE))),
        ],
      ),
    );
  }

  // ── MESSAGE INPUT BAR ───────────────────────────────────────────────────
  Widget _buildMessageInput() {
    return Container(
      color: Colors.white,
      // SafeArea bottom: true ensures the bar sits above the device home bar
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        // MediaQuery.of(context).viewInsets.bottom handles keyboard popping up
        bottom: 8 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: [

          // Attachment button
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppColors.onSurfaceVariant,
            ),
            onPressed: () {},
          ),

          // Text input — Expanded takes all remaining space between the buttons
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 14,
                ),
                filled: true,
                fillColor: const Color(0xFFEFEDF0),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none, // no visible border line
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send button — gold circle
          GestureDetector(
            onTap: () {
              // Clear the field on send — real send logic goes here later
              _messageController.clear();
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

        ],
      ),
    );
  }
}