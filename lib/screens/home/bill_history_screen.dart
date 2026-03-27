import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/mock/mock_bills.dart';
import '../../models/bill.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/status_badge.dart';

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

  List<Bill> get _filteredBills {
    final month = _months[_selectedMonth];
    return mockBills.where((b) => b.period == month).toList();
  }

  IconData _iconForService(ServiceType type) {
    switch (type) {
      case ServiceType.water:
        return Icons.water_drop_rounded;
      case ServiceType.electricity:
        return Icons.flash_on_rounded;
      case ServiceType.ratesAndTaxes:
        return Icons.account_balance_rounded;
      case ServiceType.waste:
        return Icons.delete_outline_rounded;
    }
  }

  Color _colourForService(ServiceType type) {
    switch (type) {
      case ServiceType.water:
        return AppColours.info;
      case ServiceType.electricity:
        return AppColours.amber;
      case ServiceType.ratesAndTaxes:
        return AppColours.primaryPurple;
      case ServiceType.waste:
        return AppColours.emerald;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bills = _filteredBills;

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
          // Month filter tabs
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
                  selected: isSelected,
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
          // Bill list for selected month
          Expanded(
            child: bills.isEmpty
                ? Center(
                    child: Text(
                      'No bills for this period',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColours.textSecondary,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: bills.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final bill = bills[index];
                      return _BillCard(
                        bill: bill,
                        icon: _iconForService(bill.serviceType),
                        colour: _colourForService(bill.serviceType),
                        onTap: () => context.push('/home/bill/${bill.id}'),
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
  final Bill bill;
  final IconData icon;
  final Color colour;
  final VoidCallback onTap;

  const _BillCard({
    required this.bill,
    required this.icon,
    required this.colour,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'View ${bill.serviceType.label} bill for ${bill.period}, R ${bill.totalAmount.toStringAsFixed(2)}',
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
                  color: colour.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: colour, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.serviceType.label,
                      style: AppTypography.amountMedium.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      bill.period,
                      style: AppTypography.bodySmall.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'R ${bill.totalAmount.toStringAsFixed(2)}',
                    style: AppTypography.amountMedium.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  bill.status == BillStatus.paid
                      ? StatusBadge.paid()
                      : StatusBadge.unpaid(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
