class AppUser {
  static const String name = 'Erica';
  static const String role = 'Student';
  static const String avatar = ''; 
  static const String program = 'Software Engineering';
}

class Opportunity {
  final String id;
  final String category;   
  final String title;
  final String date;
  final String location;
  final String description;
  final String organizer;
  final String actionLabel; 
  final int registeredCount;
  final int totalSlots;
  final List<String> tags;
  final String tier;
  bool isBookmarked;
  bool hasRSVPd;

  Opportunity({
    required this.id,
    required this.category,
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.organizer,
    required this.actionLabel,
    required this.registeredCount,
    required this.totalSlots,
    required this.tags,
    this.tier = '',
    this.isBookmarked = false,
    this.hasRSVPd = false,
  });
}

class CommunityPost {
  final String id;
  final String authorName;
  final String authorRole;  
  final String timeAgo;
  final String content;
  final int likes;
  final int comments;
  final bool isPinned;
  final String tab; 

  const CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.comments,
    required this.isPinned,
    required this.tab,
  });
}

// Opprtunities
final List<Opportunity> mockOpportunities = [
  Opportunity(
    id: '1',
    category: 'CAREER',
    title: 'Google Tech Mentorship 2024',
    date: 'July 12, 2026',
    location: 'Hybrid • Kigali Office',
    description:
        'An exclusive 6-month mentorship program connecting ALU students with Google engineers. '
        'You will work on real projects, receive career guidance, and build your professional network. '
        'Applications are open to all second and third-year students.',
    organizer: 'Google & ALU Careers Office',
    actionLabel: 'RSVP',
    registeredCount: 34,
    totalSlots: 50,
    tags: ['#Tech', '#Mentorship', '#Career'],
  ),
  Opportunity(
    id: '2',
    category: 'FINANCE',
    title: 'Mastercard Foundation Grants',
    date: 'Deadline: Sept 30,2026',
    location: 'Online Application',
    description:
        'Submit your social impact project proposals for a chance to receive funding up to \$5,000. '
        'Projects must address a community challenge within the African context. '
        'Open to all ALU students with a valid student ID.',
    organizer: 'Mastercard Foundation',
    actionLabel: 'Apply',
    registeredCount: 45,
    totalSlots: 60,
    tags: ['#Finance', '#Grant', '#SocialImpact'],
    
  ),
  Opportunity(
    id: '3',
    category: 'SOCIAL',
    title: 'ALU Founders Mixer',
    date: 'Today, 6:00 PM',
    location: 'ALU Leadership Center',
    description:
        'Network with student entrepreneurs and share ideas. '
        'This monthly mixer brings together aspiring founders, investors, and mentors. '
        'Light refreshments will be provided.',
    organizer: 'ALU Entrepreneurship Club',
    actionLabel: 'Join',
    registeredCount: 69,
    totalSlots: 80,
    tags: ['#Networking', '#Startup', '#Social'],
    
  ),
  Opportunity(
    id: '4',
    category: 'WELLNESS',
    title: 'Wellness Workshop',
    date: 'Thursday, June,11 • 2:00 PM – 6:00 PM CAT',
    location: 'ALU Wellness Center',
    description:
        'Join us for an immersive session focused on developing the mental resilience and emotional '
        'intelligence. We will explore practical mindfulness techniques, '
        'stress management strategies, and peer-to-peer support frameworks specifically designed for the '
        'ALU community. Lunch will be provided for all registered attendees.',
    organizer: 'SRC',
    actionLabel: 'RSVP',
    registeredCount: 34,
    totalSlots: 50,
    tags: ['#Wellness', '#Leadership', '#MentalHealth', '#ALUKigali'],
    
  ),
];

//Commmunity
const List<CommunityPost> mockCommunityPosts = [
  CommunityPost(
    id: '1',
    authorName: 'Prof. Johnathan Smith',
    authorRole: 'ADMIN',
    timeAgo: '',
    content: 'Final Capstone Project Deadline Extended\n\n'
        'Attention all seniors! We have decided to extend the project deadline by 48 hours to ensure '
        'everyone can finalize their deployments.',
    likes: 24,
    comments: 15,
    isPinned: true,
    tab: 'Announcements',
  ),
  CommunityPost(
    id: '2',
    authorName: 'Sarah Kwesi',
    authorRole: 'STUDENT',
    timeAgo: '2 hours ago',
    content:
        'Is anyone else heading to the tech talk in the main hall this afternoon? '
        'I have 2 extra seats if anyone wants to carpool from the dorms.',
    likes: 8,
    comments: 3,
    isPinned: false,
    tab: 'Discussion',
  ),
  CommunityPost(
    id: '3',
    authorName: 'ALU Careers',
    authorRole: 'ADMIN',
    timeAgo: '1 day ago',
    content: 'New internship listings are live on the portal. Check the Opportunities tab for roles at '
        'Andela, Flutterwave, and three other top African tech companies.',
    likes: 41,
    comments: 9,
    isPinned: false,
    tab: 'Announcements',
  ),
  CommunityPost(
    id: '4',
    authorName: 'Kofi Mensah',
    authorRole: 'STUDENT',
    timeAgo: '3 hours ago',
    content: 'Just finished the Flutter workshop. Honestly, one of the best sessions this semester. '
        'Highly recommend everyone to attend the next one!',
    likes: 19,
    comments: 7,
    isPinned: false,
    tab: 'Discussion',
  ),
];


const List<String> feedCategories = ['All', 'Events', 'Career', 'Finance', 'Wellness', 'Social'];
const List<String> communityTabs = ['Announcements', 'Discussion', 'Opportunities'];
 

// ─────────────────────────────────────────────
// CHAT MESSAGE MODEL
// ─────────────────────────────────────────────

// ChatMessage holds the data for one chat bubble.
class ChatMessage {
  final String senderName;  // name shown above the bubble
  final String text;        // the message text
  final String time;        // timestamp shown below the bubble
  final bool isMe;          // true = right-aligned navy bubble; false = left grey bubble
  final bool isRead;        // true = shows "Read" under sent messages
  final String? imageUrl;   // optional image above the text (nullable)

  const ChatMessage({
    required this.senderName,
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
    this.imageUrl,
  });
}

// mockChatMessages: the list of messages shown in the chat screen.
const List<ChatMessage> mockChatMessages = [
  ChatMessage(
    senderName: 'Sarah M.',
    text: 'Found this great reference for our case study!',
    time: '09:12',
    isMe: false,
    // A real Unsplash photo of a study group — matches the design
    imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400',
  ),
  ChatMessage(
    senderName: 'Me',
    text: 'Thanks Adebayo, reviewing them now. They look very professional.',
    time: '10:50',
    isMe: true,
    isRead: true,
  ),
  ChatMessage(
    senderName: 'Adebayo O.',
    text: 'The presentation slides are uploaded to the shared drive. Please take a look before the meeting.',
    time: '10:45',
    isMe: false,
  ),
  ChatMessage(
    senderName: 'Sarah M.',
    text: 'Are we still having the peer review session for the Entrepreneurship module today?',
    time: '14:18',
    isMe: false,
  ),
  ChatMessage(
    senderName: 'Me',
    text: "Absolutely! Let's meet at the Innovation Lab at 4 PM.",
    time: '14:22',
    isMe: true,
    isRead: false,
  ),
];