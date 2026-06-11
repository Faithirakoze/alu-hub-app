// main.dart
// Application entry point for ALU Hub.
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/communities_screen.dart';
import 'screens/sign_up_identity_screen.dart';
import 'screens/sign_up_interests_screen.dart';
import 'screens/explore_resources_screen.dart';
import 'screens/organizer_dashboard_screen.dart';
import 'screens/student_profile_screen.dart';
import 'screens/organizer_post_screen.dart';
import 'screens/organizer_community_screen.dart';
import 'screens/organizer_profile_screen.dart';
import 'theme/app_theme.dart';



void main() {
  // Initialize and run the application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Onboarding',
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupAccountScreen(),
        '/home': (context) => const HomeScreen(),
        '/sign-up-identity': (context) => const SignUpIdentityScreen(),
        '/sign-up-interests': (context) => const SignUpInterestsScreen(),
        '/explore-resources': (context) => const ExploreResourcesScreen(selectedInterests: []),
        '/communities': (context) => const CommunitiesScreen(),
        '/organizer-dashboard': (context) => const OrganizerDashboardScreen(),
        '/organizer-posts': (context) => const OrganizerPostScreen(),
        '/profile': (context) => const StudentProfileScreen(),
        '/organizer-communities': (context) => const OrganizerCommunityScreen(),
        '/organizer-profile': (context) => const OrganizerProfileScreen(),
      },
    );
  }
}