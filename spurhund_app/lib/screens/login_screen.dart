import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colours.dart';
import '../widgets/spuerhund_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/staggered_column.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SpuerhundSpacing.lg),
          child: StaggeredColumn(
            staggerDelay: const Duration(milliseconds: 50),
            children: [
              // Logo icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: SpuerhundColours.primaryTint,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: SpuerhundColours.primary.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.search_rounded,
                      color: SpuerhundColours.primary, size: 32),
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.lg),

              // Welcome heading
              Text(
                'Welcome Back',
                style: GoogleFonts.epilogue(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                  color: SpuerhundColours.textPrimary,
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.sm),
              Text(
                'Log in to view your municipal accounts.',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: SpuerhundColours.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.xxl),

              // Email field
              const AppTextField(
                label: 'Email Address',
                hint: 'name@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail_outline_rounded,
              ),
              const SizedBox(height: SpuerhundSpacing.lg),

              // Password field
              const AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                isPassword: true,
                prefixIcon: Icons.lock_outline_rounded,
              ),
              const SizedBox(height: SpuerhundSpacing.md),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.manrope(
                      color: SpuerhundColours.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.xl),

              // Login button
              SpuerhundButton(
                text: 'Log In',
                onPressed: () => context.go('/dashboard'),
              ),
              const SizedBox(height: SpuerhundSpacing.lg),

              // Sign up link
              Center(
                child: TextButton(
                  onPressed: () => context.push('/signup-province'),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.manrope(
                        color: SpuerhundColours.textSecondary,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: GoogleFonts.manrope(
                            color: SpuerhundColours.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
