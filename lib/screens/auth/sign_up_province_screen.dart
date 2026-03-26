import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/spuerhund_button.dart';
import '../../widgets/common/spuerhund_input.dart';

class SignUpProvinceScreen extends StatefulWidget {
  const SignUpProvinceScreen({super.key});

  @override
  State<SignUpProvinceScreen> createState() => _SignUpProvinceScreenState();
}

class _SignUpProvinceScreenState extends State<SignUpProvinceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColours.textPrimary),
          onPressed: () => context.go('/onboarding'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.shield_rounded,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Semantics(
                header: true,
                child: Text(
                  'Get Started with Sp\u00FCrhund',
                  textAlign: TextAlign.center,
                  style: AppTypography.headlineLarge.copyWith(
                    fontSize: 26,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create your account in seconds.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColours.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SpuerhundInput(
                      label: 'Email',
                      hint: 'Enter email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SpuerhundInput(
                      label: 'Password',
                      hint: 'Password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColours.textSecondary,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SpuerhundButton(
                label: 'Sign Up',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.go('/link-account');
                  }
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: Semantics(
                  button: true,
                  label: 'Log in to existing account',
                  child: GestureDetector(
                    onTap: () => context.go('/onboarding'),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColours.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                              color: AppColours.primaryPurple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColours.borderLight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColours.textTertiary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColours.borderLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: 'Sign in with Apple',
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Apple sign-in available in the full release')),
                          );
                        },
                        child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColours.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColours.borderLight),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.apple, color: Colors.white, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Apple',
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColours.textPrimary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: 'Sign in with Google',
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Google sign-in available in the full release')),
                          );
                        },
                        child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColours.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColours.borderLight),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'G',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Google',
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColours.textPrimary,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By creating an account, you agree to our ',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColours.textTertiary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: TextStyle(color: AppColours.primaryPurple),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: AppColours.primaryPurple),
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
