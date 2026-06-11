// chat_bubble.dart
// One chat message bubble — left-aligned (others) or right-aligned (me).
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/mock_data.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message; // the data for this bubble
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // isMe: determines which side of the screen the bubble appears on
    final isMe = message.isMe;

    return Padding(
      // 8px top/bottom between bubbles, 16px left/right from screen edge
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        // if isMe → align to the right (end); if not → align to the left (start)
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [

          // Sender name — only shown for other people's messages, not mine
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 4),
              child: Text(
                message.senderName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gold, // gold name label like in the design
                ),
              ),
            ),

          // The bubble itself
          Container(
            // constraints: limits the bubble to 75% of screen width max
            // so long messages don't stretch wall to wall
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              // navy for my messages, light grey for others
              color: isMe ? AppColors.navy : const Color(0xFFEFEDF0),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                // The "tail" corner: my messages have a sharp bottom-right corner,
                // others have a sharp bottom-left corner.
                bottomLeft: Radius.circular(isMe ? 16 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Optional image — only shown if imageUrl is not null
                if (message.imageUrl != null)
                  ClipRRect(
                    // ClipRRect clips the image to match the bubble's top corners
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      message.imageUrl!,  // ! asserts it's not null (we checked above)
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover, // fills the width, crops if needed
                      // errorBuilder: shown if the image fails to load
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: AppColors.surfaceContainerHighest,
                        child: const Icon(Icons.image_outlined, color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),

                // Message text
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      // white text on navy; dark text on grey
                      color: isMe ? Colors.white : AppColors.onSurface,
                    ),
                  ),
                ),

              ],
            ),
          ),

          // Timestamp + Read receipt below the bubble
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
            child: Text(
              // If it's my message and it's read, show "time • Read"
              isMe && message.isRead
                  ? '${message.time} • Read'
                  : isMe
                      ? '${message.time} • Sent'
                      : message.time,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),

        ],
      ),
    );
  }
}