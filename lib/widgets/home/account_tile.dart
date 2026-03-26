import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/account.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../common/status_badge.dart';

class AccountTile extends StatelessWidget {
  final AccountService service;

  const AccountTile({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_ZA',
      symbol: 'R ',
      decimalDigits: 2,
    );
    final dateFormat = DateFormat('d MMM');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColours.borderSubtle),
      ),
      child: Row(
        children: [
          _serviceIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.serviceType.displayName,
                  style: AppTypography.amountMedium.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                if (service.dueDate != null)
                  Text(
                    'Due ${dateFormat.format(service.dueDate!)}',
                    style: AppTypography.bodySmall.copyWith(
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
                currencyFormat.format(service.currentBalance),
                style: AppTypography.amountMedium.copyWith(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              _statusBadge(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceIcon() {
    IconData icon;
    Color color;

    switch (service.serviceType) {
      case ServiceType.water:
        icon = Icons.water_drop_rounded;
        color = AppColours.info;
      case ServiceType.electricity:
        icon = Icons.bolt_rounded;
        color = AppColours.amber;
      case ServiceType.ratesAndTaxes:
        icon = Icons.account_balance_rounded;
        color = AppColours.emerald;
      case ServiceType.waste:
      case ServiceType.refuse:
        icon = Icons.recycling_rounded;
        color = AppColours.primaryPurple;
      case ServiceType.sanitation:
        icon = Icons.plumbing_rounded;
        color = AppColours.info;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }

  StatusBadge _statusBadge() {
    switch (service.status) {
      case ServiceStatus.current:
        return StatusBadge.current();
      case ServiceStatus.dueSoon:
        return StatusBadge.dueSoon();
      case ServiceStatus.overdue:
        return StatusBadge.overdue();
      case ServiceStatus.paid:
        return StatusBadge.paid();
    }
  }
}
