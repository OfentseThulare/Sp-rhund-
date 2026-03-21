import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colours.dart';
import '../../widgets/spuerhund_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/staggered_column.dart';

class SignupDetailsScreen extends StatefulWidget {
  const SignupDetailsScreen({super.key});

  @override
  State<SignupDetailsScreen> createState() => _SignupDetailsScreenState();
}

class _SignupDetailsScreenState extends State<SignupDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Personal Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SpuerhundSpacing.lg),
          child: Form(
            key: _formKey,
            child: StaggeredColumn(
              staggerDelay: const Duration(milliseconds: 50),
              children: [
                Text(
                  'Tell us about yourself',
                  style: GoogleFonts.epilogue(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    color: SpuerhundColours.textPrimary,
                  ),
                ),
                const SizedBox(height: SpuerhundSpacing.sm),
                Text(
                  'We use these details to verify your municipal accounts securely.',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: SpuerhundColours.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: SpuerhundSpacing.xl),
                const AppTextField(
                  label: 'Full Name',
                  hint: 'As it appears on your ID',
                  prefixIcon: Icons.person_outline_rounded,
                ),
                const SizedBox(height: SpuerhundSpacing.lg),
                const AppTextField(
                  label: 'ID / Passport Number',
                  hint: 'Required for verification',
                  prefixIcon: Icons.badge_outlined,
                ),
                const SizedBox(height: SpuerhundSpacing.lg),
                const AppTextField(
                  label: 'Mobile Number',
                  hint: 'For SMS notifications',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: SpuerhundSpacing.lg),
                const AppTextField(
                  label: 'Email Address',
                  hint: 'name@example.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.mail_outline_rounded,
                ),
                const SizedBox(height: SpuerhundSpacing.lg),
                const AppTextField(
                  label: 'Password',
                  hint: 'Create a secure password',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline_rounded,
                ),
                const SizedBox(height: SpuerhundSpacing.xxl),
                SpuerhundButton(
                  text: 'Create Account',
                  onPressed: () {
                    context.push('/link-accounts');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
