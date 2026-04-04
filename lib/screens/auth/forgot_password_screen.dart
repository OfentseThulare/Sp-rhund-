import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/spuerhund_button.dart';
import '../../widgets/common/spuerhund_input.dart';
import '../../widgets/common/shield_crest.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await AuthService.resetPassword(
      email: _emailController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result.success) {
      setState(() => _emailSent = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? 'Failed to send reset email'),
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
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _emailSent ? _buildSuccessState() : _buildFormState(),
        ),
      ),
    );
  }

  Widget _buildFormState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ShieldCrest(size: 64),
        const SizedBox(height: 24),
        Semantics(
          header: true,
          child: Text(
            'Reset Password',
            textAlign: TextAlign.center,
            style: AppTypography.headlineLarge.copyWith(fontSize: 26),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter the email address linked to your account and we will send you a password reset link.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColours.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        Form(
          key: _formKey,
          child: SpuerhundInput(
            label: 'Email',
            hint: 'Enter your email',
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
        ),
        const SizedBox(height: 24),
        SpuerhundButton(
          label: 'Send Reset Link',
          isLoading: _isLoading,
          onPressed: _isLoading ? null : _handleResetPassword,
        ),
        const SizedBox(height: 24),
        Center(
          child: Semantics(
            button: true,
            label: 'Back to login',
            child: GestureDetector(
              onTap: () => context.go('/login'),
              child: Text(
                'Back to Log In',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColours.primaryPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 48),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColours.primaryPurple.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mail_outline_rounded,
            size: 40,
            color: AppColours.primaryPurple,
          ),
        ),
        const SizedBox(height: 32),
        Semantics(
          header: true,
          child: Text(
            'Check Your Email',
            textAlign: TextAlign.center,
            style: AppTypography.headlineLarge.copyWith(fontSize: 26),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'We have sent a password reset link to:',
          textAlign: TextAlign.center,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColours.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _emailController.text.trim(),
          textAlign: TextAlign.center,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColours.primaryPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'If you do not see the email, check your spam folder.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColours.textTertiary,
          ),
        ),
        const SizedBox(height: 32),
        SpuerhundButton(
          label: 'Back to Log In',
          onPressed: () => context.go('/login'),
        ),
        const SizedBox(height: 16),
        Semantics(
          button: true,
          label: 'Resend reset email',
          child: GestureDetector(
            onTap: () {
              setState(() => _emailSent = false);
            },
            child: SizedBox(
              height: 44,
              child: Center(
                child: Text(
                  'Resend email',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColours.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
