import 'package:flutter/material.dart';
import 'sign_up_interests_screen.dart';
import '../theme/app_theme.dart';

class SignUpIdentityScreen extends StatefulWidget {
  const SignUpIdentityScreen({super.key});

  @override
  State<SignUpIdentityScreen> createState() => _SignUpIdentityScreenState();
}

class _SignUpIdentityScreenState extends State<SignUpIdentityScreen> {
  final List<String> _programs = const ['BSE', 'BEL', 'IBT'];
  final List<String> _years = const ['Year 1', 'Year 2', 'Year 3'];
  final List<String> _roles = const ['Student', 'Organizer'];

  String selectedProgram = 'BSE';
  String selectedYear = 'Year 2';
  String selectedRole = 'Student';

  bool get _isStudent => selectedRole == 'Student';

  void _goNext() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignUpInterestsScreen()),
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
          'Sign Up - Identity',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.navy,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tell us about yourself',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Step 2 of 3: Identity & Program',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF111C35), Color(0xFF17284D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.16),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.school_outlined, color: AppColors.gold),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile snapshot',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'These choices help ALU Hub tailor your dashboard and recommendations.',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.white.withOpacity(0.76),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── 1. ROLE (always visible) ──────────────────────────────
              _SectionLabel(title: 'Role'),
              const SizedBox(height: 10),
              _OptionGrid(
                options: _roles,
                selectedValue: selectedRole,
                onSelected: (value) => setState(() => selectedRole = value),
              ),

              // ── 2 & 3. STUDENT-ONLY FIELDS (animated in/out) ─────────
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _isStudent
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _SectionLabel(title: 'Select your program'),
                          const SizedBox(height: 10),
                          _OptionGrid(
                            options: _programs,
                            selectedValue: selectedProgram,
                            onSelected: (value) =>
                                setState(() => selectedProgram = value),
                          ),
                          const SizedBox(height: 20),
                          _SectionLabel(title: 'Current year'),
                          const SizedBox(height: 10),
                          _OptionGrid(
                            options: _years,
                            selectedValue: selectedYear,
                            onSelected: (value) =>
                                setState(() => selectedYear = value),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 20),

              // ── SUMMARY PILLS ─────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SummaryPill(label: selectedRole),
                    if (_isStudent) _SummaryPill(label: selectedProgram),
                    if (_isStudent) _SummaryPill(label: selectedYear),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppTheme.goldButton,
                  onPressed: _goNext,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Next'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
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

// ── Sub-widgets (unchanged) ───────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            letterSpacing: 0.8,
            color: AppColors.textGrey,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _OptionGrid extends StatelessWidget {
  const _OptionGrid({
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = option == selectedValue;
        return GestureDetector(
          onTap: () => onSelected(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: MediaQuery.of(context).size.width > 420 ? 112 : 100,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.navy : AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.navy : AppColors.divider,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isSelected ? 0.12 : 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                option,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? AppColors.white : AppColors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.navy,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}