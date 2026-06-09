import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SignupAccountScreen extends StatefulWidget {
  const SignupAccountScreen({super.key});

  @override
  State<SignupAccountScreen> createState() => _SignupAccountScreenState();
}

class _SignupAccountScreenState extends State<SignupAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _onNext() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: navigate to SignupIdentityScreen (Step 2 of 3)
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // App Bar
          _SignupAppBar(),

          // Step progress bar
          _StepProgressBar(currentStep: 1, totalSteps: 3),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step label
                    Text(
                      'STEP 01 OF 03',
                      style: textTheme.labelMedium?.copyWith(
                        color: AppColors.secondary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Headline
                    Text(
                      'Create your account',
                      style: textTheme.headlineLarge?.copyWith(
                        color: AppColors.onBackground,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtext
                    Text(
                      "Let's get started with your basic student information to set up your profile.",
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Full Name field
                    _InputLabel(label: 'Full name'),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.onSurface,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Enter your full name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // University Email field
                    _InputLabel(label: 'University email'),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.onSurface,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'student@alueducation.com',
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Email is required';
                        }
                        if (!v.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    _InputLabel(label: 'Password'),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Create a secure password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: _togglePasswordVisibility,
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.outline,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Password is required';
                        }
                        if (v.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Minimum 8 characters with a mix of letters and numbers.',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Floating Next Button
      floatingActionButton: _NextButton(onNext: _onNext),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ─── App Bar ────────────────────────────────────────────────────────────────

class _SignupAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top + 64,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: AppColors.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo + name
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.brandGold,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: AppColors.primaryContainer,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'ALU Hub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            // Actions
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.onSurfaceVariant,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Step Progress Bar ───────────────────────────────────────────────────────

class _StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _StepProgressBar({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      color: AppColors.primaryContainer.withOpacity(0.15),
      child: FractionallySizedBox(
        widthFactor: currentStep / totalSteps,
        alignment: Alignment.centerLeft,
        child: Container(color: AppColors.secondaryContainer),
      ),
    );
  }
}

// ─── Next Button ─────────────────────────────────────────────────────────────

class _NextButton extends StatelessWidget {
  final VoidCallback onNext;

  const _NextButton({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryContainer,
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 4,
          ),
          label: Text(
            'Next',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.primary,
            ),
          ),
          icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
          iconAlignment: IconAlignment.end,
        ),
      ),
    );
  }
}

// ─── Input Label ────────────────────────────────────────────────────────────

class _InputLabel extends StatelessWidget {
  final String label;
  const _InputLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}