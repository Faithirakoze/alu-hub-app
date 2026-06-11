// community_list_item.dart
// One full row in the community list: coloured circle icon, name, subtitle,
// timestamp on the right, and an optional gold unread-count badge.
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CommunityListItem extends StatelessWidget {
  // All these fields describe one community row.
  // They are all final because a list item's data never changes after it's built.
  final IconData icon;      // the Material icon drawn inside the circle
  final Color avatarColor;  // background colour of the circle
  final Color iconColor;    // colour of the icon itself
  final String name;        // bold community name
  final String subtitle;    // smaller grey preview text
  final String timestamp;   // right-aligned time e.g. '14:20', 'Yesterday', 'Mon'
  final int? unreadCount;   // int? means this can be null — null = no badge shown

  const CommunityListItem({
    super.key,
    required this.icon,
    required this.avatarColor,
    required this.iconColor,
    required this.name,
    required this.subtitle,
    required this.timestamp,
    this.unreadCount, // optional — if you don't pass it, it defaults to null
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // BoxDecoration lets us combine a background colour AND a border.
      // We can't set both color: and decoration: at once on Container —
      // when using BoxDecoration, the color goes inside it.
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          // Bottom border only — acts as a thin divider between rows
          bottom: BorderSide(
            color: Color(0xFFEFEDF0), // same light grey as section header bg
            width: 1,                 // 1px thin line
          ),
        ),
      ),

      // InkWell: wraps any widget to give it a Material ripple effect on tap.
      // Without InkWell, tapping the row feels dead.
      child: InkWell(
        onTap: () {}, // empty for now — we'll add navigation later

        child: Padding(
          // 16px padding on all 4 sides — matches the design's standard margin
          padding: const EdgeInsets.all(16),

          // Row: places children side by side (left to right)
          child: Row(
            // crossAxisAlignment.center: vertically centers all children
            // in the row relative to each other
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // ── AVATAR CIRCLE ──────────────────────────────────────────────
              Container(
                width: 48,  // 48×48px — matches design spec
                height: 48,
                decoration: BoxDecoration(
                  color: avatarColor,     // the colour passed in from the parent
                  shape: BoxShape.circle, // BoxShape.circle makes this a perfect circle
                  // boxShadow: a soft shadow lifts the circle off the white card
                  boxShadow: [
                    BoxShadow(
                      // Colors.black.withOpacity(0.08) = black at 8% transparency
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4, // how blurry the shadow is
                      offset: const Offset(0, 2), // shadow 2px below, 0px sideways
                    ),
                  ],
                ),
                // Center: places the Icon exactly in the middle of the circle
                child: Center(
                  child: Icon(
                    icon,
                    color: iconColor, // colour of the icon passed in
                    size: 24,         // standard Material icon size
                  ),
                ),
              ),

              // 16px horizontal gap between circle and text
              const SizedBox(width: 16),

              // ── NAME + SUBTITLE TEXT BLOCK ─────────────────────────────────
              // Expanded: takes ALL remaining horizontal space in the Row
              // after the avatar (48px) and the right column.
              // Without Expanded, long text would overflow and crash.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // left-align text
                  mainAxisSize: MainAxisSize.min, // Column is only as tall as its text
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700, // bold name
                        color: AppColors.onSurface,
                      ),
                      // ellipsis: shows "..." if the name is too long for one line
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, // never wrap onto a second line
                    ),

                    // 2px gap between name and subtitle
                    const SizedBox(height: 2),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant, // lighter grey
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),

              // 8px gap between text block and right column
              const SizedBox(width: 8),

              // ── RIGHT COLUMN: timestamp + optional badge ───────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.end, // right-align contents
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Timestamp text
                  Text(
                    timestamp,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),

                  // if/else in widget trees: the ... (spread operator) is needed
                  // to "unpack" a list of widgets into the children list.
                  // This whole block only renders when unreadCount is not null AND > 0.
                  if (unreadCount != null && unreadCount! > 0) ...[
                    // 4px gap between timestamp and badge
                    const SizedBox(height: 4),

                    // Gold unread count pill badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold, // gold background
                        // circular(999) = a fully rounded pill shape
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        // '$unreadCount' turns the int into a string for display
                        '$unreadCount',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white, // white number on gold background
                        ),
                      ),
                    ),
                  ],

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}