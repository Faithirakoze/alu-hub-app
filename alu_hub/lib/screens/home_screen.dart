import 'package:flutter/material.dart';
import '../models/mock_data.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Opportunity> get _filtered {
    return mockOpportunities.where((o) {
      final matchesCategory = _selectedCategory == 'All' ||
          o.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          o.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1C30),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildAlertBanner(),
            _buildSearchBar(),
            _buildCategoryChips(),
            Expanded(child: _buildFeed()),
          ],
        ),
      ),
    );
  }