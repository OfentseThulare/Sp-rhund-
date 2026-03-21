import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../models/bill.dart';
import '../../view_models/accounts_view_model.dart';
import '../../widgets/common/status_badge.dart';

class BillHistoryScreen extends StatelessWidget {
  const BillHistoryScreen({super.key});

  static const _filters = ['All', 'Water', 'Electricity', 'Rates', 'Waste'];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccountsViewModel>();
    final currencyFormat = NumberFormat.currency(
      locale: 'en_ZA',
      symbol: 'R ',
      decimalDigits: 2,
    );

    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Bill History'),
      ),
      body: RefreshIndicator(
        color: AppColours.primaryPurple,
        onRefresh: vm.refresh,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final isActive = vm.activeFilter == _filters[i];
                  return GestureDetector(
                    onTap: () => vm.setFilter(_filters[i]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColours.primaryPurple
                            : AppColours.cloudGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isActive
                              ? AppColours.pureWhite
                              : AppColours.nearBlack,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ...vm.bills.map((bill) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _BillCard(
                    bill: bill,
                    formattedAmount: currencyFormat.format(bill.totalAmount),
                    onTap: () => context.push('/home/bill/${bill.id}'),
                  ),
                )),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _BillCard extends StatelessWidget {
  final Bill bill;
  final String formattedAmount;
  final VoidCallback onTap;

  const _BillCard({
    required this.bill,
    required this.formattedAmount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.period,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColours.nearBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${bill.serviceCount} services',
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
                  formattedAmount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColours.nearBlack,
                  ),
                ),
                const SizedBox(height: 4),
                bill.status == BillStatus.paid
                    ? StatusBadge.paid()
                    : StatusBadge.unpaid(),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColours.fog),
          ],
        ),
      ),
    );
  }
}
