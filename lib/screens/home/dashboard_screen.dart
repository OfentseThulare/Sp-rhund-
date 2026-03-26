import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../view_models/dashboard_view_model.dart';
import '../../models/account.dart';
import '../../models/service_status.dart';
import '../../widgets/home/balance_card.dart';
import '../../widgets/home/account_tile.dart';
import '../../widgets/home/quick_actions_row.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/area/status_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning, Lionel';
    if (hour < 17) return 'Good afternoon, Lionel';
    return 'Good evening, Lionel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColours.primaryPurple,
          onRefresh: context.read<DashboardViewModel>().refresh,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
            children: [
              _buildTopBar(context),
              const SizedBox(height: 8),
              Text(
                _greeting(),
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColours.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Selector<DashboardViewModel, ({double balance, DateTime? dueDate})>(
                selector: (_, vm) => (balance: vm.totalBalance, dueDate: vm.nextDueDate),
                builder: (_, data, __) => BalanceCard(
                  totalBalance: data.balance,
                  nextDueDate: data.dueDate,
                ),
              ),
              const SizedBox(height: 24),
              const QuickActionsRow(),
              const SizedBox(height: 24),
              SectionHeader(
                title: 'Your Accounts',
                actionLabel: 'See all',
                onAction: () => context.push('/home/history'),
              ),
              const SizedBox(height: 8),
              Selector<DashboardViewModel, List<AccountService>>(
                selector: (_, vm) => vm.allServices,
                builder: (_, services, __) => Column(
                  children: services.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AccountTile(service: s),
                  )).toList(),
                ),
              ),
              Selector<DashboardViewModel, List<ServiceAlert>>(
                selector: (_, vm) => vm.recentAlerts,
                builder: (_, alerts, __) {
                  if (alerts.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const SectionHeader(title: 'Alerts'),
                      const SizedBox(height: 8),
                      ...alerts.map((a) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: StatusCard(alert: a),
                      )),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        Semantics(
          header: true,
          child: const Text(
            'SPÜRHUND',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColours.primaryPurple,
              letterSpacing: 3,
            ),
          ),
        ),
        const Spacer(),
        Selector<DashboardViewModel, int>(
          selector: (_, vm) => vm.unreadNotifications,
          builder: (_, unread, __) => Semantics(
            button: true,
            label: 'View notifications',
            child: GestureDetector(
              onTap: () => context.push('/home/notifications'),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: AppColours.textPrimary,
                    size: 24,
                  ),
                  if (unread > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColours.crimson,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
