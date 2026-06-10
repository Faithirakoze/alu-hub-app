import 'package:flutter/material.dart';
import 'explore_resources_screen.dart';
import '../theme/app_theme.dart';

class SignUpInterestsScreen extends StatefulWidget {
  const SignUpInterestsScreen({super.key});

  @override
  State<SignUpInterestsScreen> createState() => _SignUpInterestsScreenState();
}

class _SignUpInterestsScreenState extends State<SignUpInterestsScreen> {
  final List<_InterestOption> _options = const [
    _InterestOption('Finance', Icons.account_balance_wallet_outlined),
    _InterestOption('Career', Icons.work_outline),
    _InterestOption('Wellness', Icons.favorite_border_rounded),
    _InterestOption('Community', Icons.groups_outlined),
    _InterestOption('Startups', Icons.rocket_launch_outlined),
    _InterestOption('Academic', Icons.menu_book_outlined),
    _InterestOption('Student Life', Icons.coffee_outlined),
    _InterestOption('Practical Life', Icons.handyman_outlined),
  ];

  final Set<String> _selectedInterests = {};

  void _finishSetup() {
    if (_selectedInterests.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick at least one interest to personalize your feed.')),
      );
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => ExploreResourcesScreen(
          selectedInterests: _selectedInterests.toList(growable: false),
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.navy),
        title: Text(
          'Step 3 of 3',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.navy,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What matters most to you?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Select your interests to personalize your ALU Hub experience.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.tune_rounded, color: AppColors.navy),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_selectedInterests.length} interests selected',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your feed will prioritize topics you choose here.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _options.map((option) {
                      final isSelected = _selectedInterests.contains(option.label);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedInterests.remove(option.label);
                            } else {
                              _selectedInterests.add(option.label);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.navy : AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.navy : AppColors.divider,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(isSelected ? 0.1 : 0.04),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isSelected ? Icons.check_circle_rounded : option.icon,
                                size: 18,
                                color: isSelected ? AppColors.gold : AppColors.textGrey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                option.label,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: isSelected ? AppColors.white : AppColors.textDark,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (_selectedInterests.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedInterests.map((interest) {
                    return Chip(
                      label: Text(interest),
                      backgroundColor: AppColors.gold.withOpacity(0.16),
                      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.navy,
                            fontWeight: FontWeight.w600,
                          ),
                      side: BorderSide.none,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppTheme.goldButton,
                  onPressed: _finishSetup,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Set Up My Hub'),
                      SizedBox(width: 8),
                      Icon(Icons.flash_on_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InterestOption {
  const _InterestOption(this.label, this.icon);

  final String label;
  final IconData icon;
}