import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../view_models/dashboard_view_model.dart';
import '../../widgets/home/balance_card.dart';
import '../../widgets/home/account_tile.dart';
import '../../widgets/home/quick_actions_row.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/area/status_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashboardViewModel>();

    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColours.primaryPurple,
          onRefresh: vm.refresh,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 16),
              _buildTopBar(vm),
              const SizedBox(height: 24),
              BalanceCard(
                totalBalance: vm.totalBalance,
                nextDueDate: vm.nextDueDate,
              ),
              const SizedBox(height: 24),
              const QuickActionsRow(),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Your Accounts'),
              const SizedBox(height: 8),
              ...vm.allServices.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AccountTile(service: s),
                  )),
              if (vm.recentAlerts.isNotEmpty) ...[
                const SizedBox(height: 8),
                const SectionHeader(title: 'Alerts'),
                const SizedBox(height: 8),
                ...vm.recentAlerts.map((a) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StatusCard(alert: a),
                    )),
              ],
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(DashboardViewModel vm) {
    return Row(
      children: [
        const Text(
          'SPURHUND',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColours.primaryPurple,
            letterSpacing: 3,
          ),
        ),
        const Spacer(),
        const Text(
          'Good morning, Lionel',
          style: TextStyle(
            fontSize: 14,
            color: AppColours.slate,
          ),
        ),
        const SizedBox(width: 12),
        Stack(
          children: [
            const Icon(Icons.notifications_outlined, color: AppColours.nearBlack),
            if (vm.unreadNotifications > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColours.crimson,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${vm.unreadNotifications}',
                      style: const TextStyle(
                        color: AppColours.pureWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
