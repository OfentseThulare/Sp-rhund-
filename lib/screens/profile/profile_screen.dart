import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../view_models/auth_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();
    final user = authVm.user;
    final displayName = user?.fullName ?? 'User';
    final initials = user?.initials ?? '?';
    final email = user?.email ?? '';
    final phone = user?.phone ?? '';

    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  'Profile',
                  style: AppTypography.headlineMedium,
                ),
              ),
              const SizedBox(height: 24),

              // Avatar
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColours.surface,
                    border: Border.all(color: AppColours.borderLight),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initials,
                    style: AppTypography.headlineLarge.copyWith(
                      color: AppColours.primaryPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  displayName,
                  style: AppTypography.headlineSmall.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  email,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColours.textSecondary,
                  ),
                ),
              ),
              if (phone.isNotEmpty) ...[
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    phone,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColours.textSecondary,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 32),

              // Linked Account
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColours.surface,
                  border: Border.all(color: AppColours.borderSubtle),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _AccountRow(label: 'Municipality', value: 'City of Tshwane'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1, color: AppColours.divider),
                    ),
                    _AccountRow(label: 'Account Number', value: 'ACC-TSH-2026-0847'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(height: 1, color: AppColours.divider),
                    ),
                    _AccountRow(label: 'Property Type', value: 'Flat'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Notifications
              _SettingsCard(
                title: 'Notifications',
                semanticLabel: 'Notifications settings',
                trailing: const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColours.textTertiary,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notification preferences coming in the next update'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Appearance
              _SettingsCard(
                title: 'Appearance',
                semanticLabel: 'Appearance settings',
                trailing: Text(
                  'Dark',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColours.textTertiary,
                  ),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appearance settings coming in the next update'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // About
              _SettingsCard(
                title: 'About',
                semanticLabel: 'About Sp\u00FCrhund',
                trailing: const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColours.textTertiary,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('App information coming in the next update'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Sign Out
              _SettingsCard(
                title: 'Sign Out',
                semanticLabel: 'Sign out',
                titleColour: AppColours.crimson,
                trailing: const SizedBox.shrink(),
                onTap: () async {
                  await context.read<AuthViewModel>().signOut();
                  if (context.mounted) {
                    context.go('/onboarding');
                  }
                },
              ),

              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Sp\u00FCrhund v1.0',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColours.textTertiary,
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

class _AccountRow extends StatelessWidget {
  final String label;
  final String value;

  const _AccountRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            fontSize: 13,
            color: AppColours.textTertiary,
          ),
        ),
        Text(
          value,
          style: AppTypography.labelLarge.copyWith(
            color: AppColours.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final String title;
  final Color? titleColour;
  final Widget trailing;
  final VoidCallback onTap;
  final String? semanticLabel;

  const _SettingsCard({
    required this.title,
    this.titleColour,
    required this.trailing,
    required this.onTap,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel ?? title,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColours.surface,
          border: Border.all(color: AppColours.borderSubtle),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: AppTypography.bodyLarge.copyWith(
                fontSize: 15,
                color: titleColour ?? AppColours.textPrimary,
              ),
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
      ),
    );
  }
}
