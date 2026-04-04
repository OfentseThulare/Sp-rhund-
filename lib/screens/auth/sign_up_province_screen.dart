import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../view_models/auth_view_model.dart';
import '../../widgets/common/spuerhund_button.dart';
import '../../widgets/common/spuerhund_input.dart';
import '../../widgets/common/shield_crest.dart';

class SignUpProvinceScreen extends StatefulWidget {
  const SignUpProvinceScreen({super.key});

  @override
  State<SignUpProvinceScreen> createState() => _SignUpProvinceScreenState();
}

class _SignUpProvinceScreenState extends State<SignUpProvinceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authVm = context.read<AuthViewModel>();
    final success = await authVm.signUpWithSupabase(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      if (authVm.needsEmailConfirmation) {
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              backgroundColor: AppColours.surface,
              title: Text(
                'Check Your Email',
                style: AppTypography.headlineSmall,
              ),
              content: Text(
                'We have sent a confirmation link to ${_emailController.text.trim()}. Please confirm your email, then log in.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColours.textSecondary,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.go('/login');
                  },
                  child: Text(
                    'Go to Log In',
                    style: TextStyle(color: AppColours.primaryPurple),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        context.go('/link-account');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authVm.errorMessage ?? 'Sign up failed'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
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
              const ShieldCrest(size: 64),
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
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                      label: 'Phone (optional)',
                      hint: '+27 XX XXX XXXX',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    SpuerhundInput(
                      label: 'Password',
                      hint: 'Password (min 6 characters)',
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
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleSignUp,
              ),
              const SizedBox(height: 16),
              Center(
                child: Semantics(
                  button: true,
                  label: 'Log in to existing account',
                  child: GestureDetector(
                    onTap: () => context.go('/login'),
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
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: AppColours.primaryPurple),
                    ),
                    const TextSpan(text: '.'),
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
