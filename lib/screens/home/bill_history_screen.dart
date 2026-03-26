import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/status_badge.dart';

class _BillItem {
  final IconData icon;
  final Color color;
  final String service;
  final String period;
  final String amount;
  final bool isPaid;

  const _BillItem({
    required this.icon,
    required this.color,
    required this.service,
    required this.period,
    required this.amount,
    required this.isPaid,
  });
}

class BillHistoryScreen extends StatefulWidget {
  const BillHistoryScreen({super.key});

  @override
  State<BillHistoryScreen> createState() => _BillHistoryScreenState();
}

class _BillHistoryScreenState extends State<BillHistoryScreen> {
  static const _months = [
    'Mar 2026',
    'Feb 2026',
    'Jan 2026',
    'Dec 2025',
    'Nov 2025',
    'Oct 2025',
  ];

  int _selectedMonth = 0;

  static final _bills = [
    _BillItem(
      icon: Icons.water_drop_rounded,
      color: AppColours.info,
      service: 'Water',
      period: 'Mar 2026',
      amount: 'R 456.78',
      isPaid: false,
    ),
    _BillItem(
      icon: Icons.flash_on_rounded,
      color: AppColours.amber,
      service: 'Electricity',
      period: 'Mar 2026',
      amount: 'R 892.45',
      isPaid: false,
    ),
    _BillItem(
      icon: Icons.account_balance_rounded,
      color: AppColours.primaryPurple,
      service: 'Rates & Taxes',
      period: 'Mar 2026',
      amount: 'R 1,247.00',
      isPaid: true,
    ),
    _BillItem(
      icon: Icons.delete_outline_rounded,
      color: AppColours.emerald,
      service: 'Waste',
      period: 'Mar 2026',
      amount: 'R 251.40',
      isPaid: false,
    ),
    _BillItem(
      icon: Icons.water_drop_rounded,
      color: AppColours.info,
      service: 'Water',
      period: 'Feb 2026',
      amount: 'R 423.12',
      isPaid: true,
    ),
    _BillItem(
      icon: Icons.flash_on_rounded,
      color: AppColours.amber,
      service: 'Electricity',
      period: 'Feb 2026',
      amount: 'R 834.90',
      isPaid: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColours.voidBlack,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColours.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Semantics(
          header: true,
          child: Text(
            'Bill History',
            style: AppTypography.headlineSmall,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _months.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = _selectedMonth == index;
                return Semantics(
                  button: true,
                  label: 'Filter by ${_months[index]}',
                  child: GestureDetector(
                  onTap: () => setState(() => _selectedMonth = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColours.primaryPurple
                          : AppColours.surface,
                      border: isSelected
                          ? null
                          : Border.all(color: AppColours.borderLight),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _months[index],
                      style: AppTypography.labelLarge.copyWith(
                        color: isSelected
                            ? AppColours.pureWhite
                            : AppColours.textSecondary,
                      ),
                    ),
                  ),
                ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _bills.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final bill = _bills[index];
                return _BillCard(
                  bill: bill,
                  onTap: () => context.push('/home/bill/$index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BillCard extends StatelessWidget {
  final _BillItem bill;
  final VoidCallback onTap;

  const _BillCard({required this.bill, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'View bill details for ${bill.service}',
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bill.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                bill.icon,
                color: bill.color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.service,
                    style: AppTypography.amountMedium.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    bill.period,
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
                  bill.amount,
                  style: AppTypography.amountMedium.copyWith(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                bill.isPaid ? StatusBadge.paid() : StatusBadge.unpaid(),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
