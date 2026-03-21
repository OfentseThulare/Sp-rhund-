import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/colours.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final DateTime? nextDueDate;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    this.nextDueDate,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_ZA',
      symbol: 'R ',
      decimalDigits: 2,
    );
    final dateFormat = DateFormat('d MMMM yyyy');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColours.primaryPurple, AppColours.deepViolet],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Amount Due',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColours.pureWhite.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currencyFormat.format(totalBalance),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColours.pureWhite,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          if (nextDueDate != null) ...[
            const SizedBox(height: 8),
            Text(
              'Next due: ${dateFormat.format(nextDueDate!)}',
              style: TextStyle(
                fontSize: 13,
                color: AppColours.pureWhite.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
