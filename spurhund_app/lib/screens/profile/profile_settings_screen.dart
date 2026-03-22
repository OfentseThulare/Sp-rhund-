import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colours.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/staggered_column.dart';
import '../../view_models/user_view_model.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().loadUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userVm = context.watch<UserViewModel>();

    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: userVm.isLoading
                ? const Center(child: BalanceCardSkeleton())
                : ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpuerhundSpacing.lg,
                      vertical: SpuerhundSpacing.md,
                    ).copyWith(bottom: 120),
                    children: [
                      // Profile avatar and name
                      FadeSlideIn(
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: SpuerhundColours.primaryTint,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: SpuerhundColours.border, width: 3),
                                  boxShadow: SpuerhundShadows.elevated,
                                ),
                                child: Center(
                                  child: Text(
                                    userVm.userProfile?.avatarInitials ??
                                        'ML',
                                    style: GoogleFonts.epilogue(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: SpuerhundColours.primary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: SpuerhundSpacing.md),
                              Text(
                                userVm.userProfile?.fullName ?? 'Lionel',
                                style: GoogleFonts.epilogue(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                  color: SpuerhundColours.textPrimary,
                                ),
                              ),
                              const SizedBox(height: SpuerhundSpacing.xs),
                              Text(
                                userVm.userProfile?.email ??
                                    'lionel@email.co.za',
                                style: GoogleFonts.manrope(
                                  color: SpuerhundColours.textSecondary,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: SpuerhundSpacing.xxl),

                      // Account Settings
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Settings',
                              style: GoogleFonts.epilogue(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                color: SpuerhundColours.textPrimary,
                              ),
                            ),
                            const SizedBox(height: SpuerhundSpacing.md),
                            _buildSettingsGroup([
                              _SettingItem(Icons.person_outline_rounded,
                                  'Personal Details'),
                              _SettingItem(Icons.home_work_outlined,
                                  'Linked Properties'),
                              _SettingItem(Icons.notifications_none_rounded,
                                  'Notification Preferences'),
                              _SettingItem(Icons.security_rounded,
                                  'Security & Privacy'),
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpuerhundSpacing.xl),

                      // Support
                      FadeSlideIn(
                        delay: const Duration(milliseconds: 200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Support',
                              style: GoogleFonts.epilogue(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                                color: SpuerhundColours.textPrimary,
                              ),
                            ),
                            const SizedBox(height: SpuerhundSpacing.md),
                            _buildSettingsGroup([
                              _SettingItem(
                                  Icons.help_outline_rounded, 'Help Centre'),
                              _SettingItem(Icons.article_outlined,
                                  'Terms of Service'),
                              _SettingItem(Icons.logout_rounded, 'Log Out',
                                  isDestructive: true),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: SpuerhundNavBar(currentIndex: 3),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(List<_SettingItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: SpuerhundColours.surface,
        borderRadius: BorderRadius.circular(SpuerhundRadius.lg),
        border: Border.all(color: SpuerhundColours.border),
        boxShadow: SpuerhundShadows.subtle,
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final item = entry.value;
          final isLast = entry.key == items.length - 1;
          final color = item.isDestructive
              ? SpuerhundColours.error
              : SpuerhundColours.textPrimary;

          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 6),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.isDestructive
                        ? SpuerhundColours.errorTint
                        : SpuerhundColours.surfaceMuted,
                    borderRadius:
                        BorderRadius.circular(SpuerhundRadius.xs),
                  ),
                  child: Icon(item.icon, color: color, size: 20),
                ),
                title: Text(
                  item.title,
                  style: GoogleFonts.manrope(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                trailing: item.isDestructive
                    ? null
                    : const Icon(Icons.chevron_right_rounded,
                        color: SpuerhundColours.textTertiary, size: 20),
                onTap: () {},
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: SpuerhundColours.divider,
                  indent: 76,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String title;
  final bool isDestructive;

  const _SettingItem(this.icon, this.title, {this.isDestructive = false});
}
