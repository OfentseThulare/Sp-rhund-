import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/account.dart';
import '../../theme/colours.dart';
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
        color: AppColours.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColours.nearBlack,
                  ),
                ),
                const SizedBox(height: 2),
                if (service.dueDate != null)
                  Text(
                    'Due ${dateFormat.format(service.dueDate!)}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColours.slate,
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
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColours.nearBlack,
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
        color = const Color(0xFF3B82F6);
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
        color = const Color(0xFF3B82F6);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
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
