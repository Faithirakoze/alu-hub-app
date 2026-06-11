# ALU-HUB-APP

# Overview

ALU Hub is a flutter based mobile application designed to improve student engagement and collaboration within the African Leadership University ecosystem.

The platform provides a  space where users, such as club leaders, event organizers, entrepreneurs, and student communities, can post opportunities and activities, while students can discover, join, and engage with them.

#Problem Statement  

ALU students usually get to know about opportunities through Email and WhatsApp community groups, this reults into some students missing valuable opportunities such as events, hackathons, workshops, internships, etc. ALU-HUB brings communities and opportunities together, allowing  organizers to post events and students to view different opportunities in a single platform.



## 🎯 Key Features

### For Students
- *Authentication & Onboarding*: Secure sign-up with role selection, interest preferences, and academic profile setup
- *Community Directory*: Browse and join multiple communities categorized by:
  - Programs (BSE, BEL, IBT)
  - Career focuses
  - Clubs and special interest groups
- *Opportunity Discovery*: Real-time access to:
  - Events and workshops
  - Hackathons and competitions
  - Networking mixers
  - Wellness sessions
  - Career development programs
- *Student Profile*: Personalized profile with interests, achievements, and community memberships
- *Resource Access*: Quick links to essential services:
  - Tuition Payment Portal
  - Scholarship Applications
  - Career Services
  - Academic Support
  - Wellness Center

### For Organizers
- *Dashboard Analytics*: Overview of community statistics and member engagement
- *Event Management*: Create, publish, and manage community posts and announcements
- *Community Management*: Organize and moderate community channels by program and interest
- *Member Engagement*: Track event registrations, RSVPs, and attendee metrics
- *Profile Management*: Showcase community focus areas and organizer credentials

---


# Technologies used

Flutter

Dart

Material Design

# Prerequisites
- Install flutter SDK (https://flutter.dev/docs/get-started/install)
- Android Studio (for Android development)
- Git
- vscode


# Project Structure


alu_hub/lib/
├── main.dart
├── preview_main.dart
├── theme/
│   └── app_theme.dart
├── screens/
│   ├── welcome_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── sign_up_identity_screen.dart
│   ├── sign_up_interests_screen.dart
│   ├── home_screen.dart
│   ├── communities_screen.dart
│   ├── community_directory_screen.dart
│   ├── explore_resources_screen.dart
│   ├── student_profile_screen.dart
│   ├── organizer_dashboard_screen.dart
│   ├── organizer_post_screen.dart
│   ├── organizer_community_screen.dart
│   ├── organizer_profile_screen.dart
│   └── group_chat_screen.dart
├── widgets/
│   ├── community_app_bar.dart
│   ├── section_header.dart
│   └── community_list_item.dart
├── models/
│   └── mock_data.dart
└── test/
    └── widget_test.dart

#  Minimum Requirements:
  
- Dart SDK: ^3.11.5
- Flutter: Latest stable
- iOS: 11.0+
- Android: API 21+

# Setup

1. *Clone the repository*
   
   git clone https://github.com/Faithirakoze/alu-hub-app.git
   
   cd alu-hub-app/alu_hub
   
    flutter pub get
   
 **iOS**:
flutter run -d iphone

**Android**:
flutter run -d android

 **Linux/Windows**:
flutter run

