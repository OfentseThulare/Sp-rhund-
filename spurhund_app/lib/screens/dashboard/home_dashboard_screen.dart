import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../theme/colours.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/staggered_column.dart';
import '../../view_models/account_view_model.dart';
import '../../view_models/user_view_model.dart';
import '../../models/account.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().loadUserProfile();
      context.read<AccountViewModel>().loadAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userVm = context.watch<UserViewModel>();
    final accountVm = context.watch<AccountViewModel>();
    final formatter = NumberFormat.currency(locale: 'en_ZA', symbol: 'R');

    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      body: Stack(
        children: [
          // Background gradient orbs
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    SpuerhundColours.primaryTint.withValues(alpha: 0.6),
                    SpuerhundColours.primaryTint.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SpuerhundColours.primary.withValues(alpha: 0.03),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<AccountViewModel>().loadAccounts();
              },
              color: SpuerhundColours.primary,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpuerhundSpacing.lg,
                  vertical: SpuerhundSpacing.md,
                ),
                children: [
                  // Header
                  _buildHeader(userVm),
                  const SizedBox(height: SpuerhundSpacing.xl),

                  // Total Due Card
                  accountVm.isLoading
                      ? const BalanceCardSkeleton()
                      : _buildTotalDueCard(accountVm, formatter),
                  const SizedBox(height: SpuerhundSpacing.xl),

                  // Quick Actions
                  _buildQuickActions(context),
                  const SizedBox(height: SpuerhundSpacing.xl),

                  // Accounts Section
                  Text(
                    'Your Accounts',
                    style: GoogleFonts.epilogue(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: SpuerhundColours.textPrimary,
                    ),
                  ),
                  const SizedBox(height: SpuerhundSpacing.md),

                  if (accountVm.isLoading)
                    ...List.generate(
                      3,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListItemSkeleton(),
                      ),
                    )
                  else if (accountVm.accounts.isEmpty)
                    _buildEmptyState()
                  else
                    ...accountVm.accounts.asMap().entries.map(
                          (entry) => FadeSlideIn(
                            delay: Duration(milliseconds: entry.key * 80),
                            child: _buildAccountItem(
                                entry.value, formatter),
                          ),
                        ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),

          // Floating Bottom Navigation
          const Align(
            alignment: Alignment.bottomCenter,
            child: SpuerhundNavBar(currentIndex: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(UserViewModel userVm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, ${userVm.userProfile?.fullName.split(' ').first ?? 'Lionel'}.',
                style: GoogleFonts.epilogue(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                  color: SpuerhundColours.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userVm.userProfile?.propertyType ?? 'Sectional Title',
                style: GoogleFonts.manrope(
                  color: SpuerhundColours.textSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.go('/profile'),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: SpuerhundColours.primaryTint,
              borderRadius: BorderRadius.circular(SpuerhundRadius.md),
              border: Border.all(
                color: SpuerhundColours.primary.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                userVm.userProfile?.avatarInitials ?? 'ML',
                style: GoogleFonts.epilogue(
                  color: SpuerhundColours.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalDueCard(
      AccountViewModel accountVm, NumberFormat formatter) {
    return GlassCard(
      isDoubleBezel: true,
      padding: const EdgeInsets.all(SpuerhundSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Municipal Due',
                style: GoogleFonts.manrope(
                  color: SpuerhundColours.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: SpuerhundColours.errorTint,
                  borderRadius: BorderRadius.circular(SpuerhundRadius.pill),
                ),
                child: Text(
                  'Due Soon',
                  style: GoogleFonts.manrope(
                    color: SpuerhundColours.error,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpuerhundSpacing.md),
          if (accountVm.accounts.isNotEmpty)
            Text(
              formatter.format(accountVm.accounts.first.totalBalance),
              style: GoogleFonts.epilogue(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                letterSpacing: -2,
                color: SpuerhundColours.textPrimary,
              ),
            ),
          const SizedBox(height: SpuerhundSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: SpuerhundColours.textPrimary,
                    borderRadius:
                        BorderRadius.circular(SpuerhundRadius.pill),
                  ),
                  child: Center(
                    child: Text(
                      'Pay Now',
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: SpuerhundSpacing.md),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: SpuerhundColours.divider),
                ),
                child: const Icon(Icons.download_rounded,
                    color: SpuerhundColours.textPrimary, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      (Icons.receipt_long_rounded, 'Bills', () => context.go('/bills')),
      (Icons.report_problem_rounded, 'Disputes', () => context.push('/disputes')),
      (Icons.wifi_protected_setup_rounded, 'Status', () => context.go('/status')),
      (Icons.support_agent_rounded, 'Help', () => context.push('/contacts')),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.asMap().entries.map((entry) {
        final (icon, label, onTap) = entry.value;
        return FadeSlideIn(
          delay: Duration(milliseconds: 100 + entry.key * 60),
          child: _QuickActionItem(icon: icon, label: label, onTap: onTap),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(SpuerhundSpacing.xl),
      decoration: BoxDecoration(
        color: SpuerhundColours.surfaceMuted,
        borderRadius: BorderRadius.circular(SpuerhundRadius.lg),
        border: Border.all(color: SpuerhundColours.border),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_outlined,
            size: 48,
            color: SpuerhundColours.textTertiary,
          ),
          const SizedBox(height: SpuerhundSpacing.md),
          Text(
            'No accounts linked yet',
            style: GoogleFonts.epilogue(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: SpuerhundColours.textPrimary,
            ),
          ),
          const SizedBox(height: SpuerhundSpacing.sm),
          Text(
            'Link your municipal account to start tracking bills and services.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              color: SpuerhundColours.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(Account account, NumberFormat formatter) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SpuerhundColours.surface,
        borderRadius: BorderRadius.circular(SpuerhundRadius.lg),
        border: Border.all(color: SpuerhundColours.border),
        boxShadow: SpuerhundShadows.subtle,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: SpuerhundColours.primaryTint,
              borderRadius: BorderRadius.circular(SpuerhundRadius.sm),
            ),
            child: const Icon(Icons.home_work_rounded,
                color: SpuerhundColours.primary, size: 22),
          ),
          const SizedBox(width: SpuerhundSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.accountNumber,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: SpuerhundColours.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  account.municipality,
                  style: GoogleFonts.manrope(
                    color: SpuerhundColours.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatter.format(account.totalBalance),
                style: GoogleFonts.epilogue(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Due in 5d',
                style: GoogleFonts.manrope(
                  color: SpuerhundColours.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Quick action button with tactile press feedback.
class _QuickActionItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_QuickActionItem> createState() => _QuickActionItemState();
}

class _QuickActionItemState extends State<_QuickActionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: SpuerhundDurations.micro,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: SpuerhundCurves.snappy),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(scale: _scale.value, child: child);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: SpuerhundColours.surface,
                shape: BoxShape.circle,
                boxShadow: SpuerhundShadows.subtle,
                border: Border.all(
                  color: SpuerhundColours.border,
                  width: 1,
                ),
              ),
              child: Icon(widget.icon,
                  color: SpuerhundColours.primary, size: 24),
            ),
            const SizedBox(height: SpuerhundSpacing.sm),
            Text(
              widget.label,
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: SpuerhundColours.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
