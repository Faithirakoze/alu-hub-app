// community_app_bar.dart
// This is a custom AppBar widget for the Community Directory screen.
// We put it in a separate file so any screen can reuse it just by importing it.
import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; // gives us AppColors

// implements PreferredSizeWidget — this is an interface (a contract) Flutter
// requires for any widget used in the appBar: slot of a Scaffold.
// It tells Flutter exactly how tall the AppBar is so the body starts below it.
class CommunityAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommunityAppBar({super.key});

  @override
  // preferredSize is the one property PreferredSizeWidget demands we provide.
  // kToolbarHeight is Flutter's built-in constant = 56px (standard AppBar height).
  // Size.fromHeight() creates a Size where width is unconstrained and height = 56px.
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: paints the whole AppBar in our brand navy colour
      backgroundColor: AppColors.navy,

      // automaticallyImplyLeading: false — by default Flutter puts a back arrow
      // on the left side of any AppBar that's not on the root screen.
      // We don't want that here, so we turn it off.
      automaticallyImplyLeading: false,

      // titleSpacing: 0 removes Flutter's default left padding on the title slot
      // so our Row widget controls its own horizontal spacing.
      titleSpacing: 0,

      // title: the main content area of the AppBar.
      // We put a Padding + Row here to build our custom left/right layout.
      title: Padding(
        // EdgeInsets.symmetric(horizontal: 16) = 16px gap on left AND right
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          // spaceBetween: pushes children to opposite ends of the row.
          // Left group goes left, bell button goes right.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // ── LEFT GROUP: avatar + "ALU Hub" text ──────────────────────────
            Row(
              // MainAxisSize.min: this Row only takes as much width as its children
              // need — it won't stretch to fill the screen.
              mainAxisSize: MainAxisSize.min,
              children: [

                // CircleAvatar: a built-in Flutter widget that shows a round image.
                CircleAvatar(
                  radius: 20, // radius 20 = diameter 40px (matches the design)
                  // backgroundImage: loads the image.
                  // NetworkImage fetches a URL from the internet at runtime.
                  // We use ui-avatars.com which generates a placeholder from initials.
                  backgroundImage: const NetworkImage(
                    'https://ui-avatars.com/api/?name=ALU+Student&background=0d1b33&color=fff&bold=true',
                  ),
                ),

                // SizedBox with only width = a horizontal spacer.
                // 12px gap between the avatar and the "ALU Hub" text.
                const SizedBox(width: 12),

                // The brand wordmark text
                const Text(
                  'ALU Hub',
                  style: TextStyle(
                    fontSize: 22,             // large headline size
                    fontWeight: FontWeight.w700, // bold
                    color: AppColors.white,   // white text on navy background
                    letterSpacing: -0.5,      // slightly tighter spacing
                  ),
                ),
              ],
            ),

            // ── RIGHT: notification bell ──────────────────────────────────────
            IconButton(
              // onPressed: what happens when tapped. Empty for now — we'll wire
              // it to a notifications screen later.
              onPressed: () {},

              // Icon() takes a built-in Flutter icon constant.
              // notifications_outlined = the outlined (not filled) bell icon.
              icon: const Icon(Icons.notifications_outlined),

              // color: the icon colour — white to contrast with navy background.
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}