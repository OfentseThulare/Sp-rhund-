import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../data/mock/mock_bills.dart';
import '../../models/bill.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/common/spuerhund_button.dart';

class BillDetailScreen extends StatelessWidget {
  final String billId;

  const BillDetailScreen({super.key, required this.billId});

  Bill? get _bill {
    try {
      return mockBills.firstWhere((b) => b.id == billId);
    } catch (_) {
      return null;
    }
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

  String _formatDate(DateTime? date) {
    if (date == null) return '—';
    return DateFormat('d MMM yyyy').format(date);
  }

  String _formatAmount(double amount) {
    return 'R ${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final bill = _bill;

    if (bill == null) {
      return Scaffold(
        backgroundColor: AppColours.voidBlack,
        appBar: AppBar(
          backgroundColor: AppColours.voidBlack,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColours.textPrimary),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Text(
            'Bill not found',
            style: AppTypography.bodyMedium.copyWith(color: AppColours.textSecondary),
          ),
        ),
      );
    }

    final icon = _iconForService(bill.serviceType);
    final colour = _colourForService(bill.serviceType);
    final details = bill.details;

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
            'Bill Details',
            style: AppTypography.headlineSmall,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Service header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colour.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: colour, size: 24),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bill.serviceType.label,
                      style: AppTypography.headlineMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${bill.serviceType.accountPrefix}-${bill.period.replaceAll(' ', '-')}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColours.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Info row
            Row(
              children: [
                Expanded(child: _infoColumn('Bill Period', bill.period)),
                Expanded(child: _infoColumn('Issue Date', _formatDate(bill.issuedDate))),
                Expanded(child: _infoColumn('Due Date', _formatDate(bill.dueDate))),
              ],
            ),
            const SizedBox(height: 24),
            // Breakdown card
            if (details != null) _buildBreakdownCard(details, bill.totalAmount),
            if (details == null) _buildSimpleTotal(bill.totalAmount),
            const SizedBox(height: 24),
            // Payment status
            bill.status == BillStatus.paid ? StatusBadge.paid() : StatusBadge.unpaid(),
            const SizedBox(height: 24),
            SpuerhundButton(
              label: 'Download Statement',
              isOutlined: true,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Statement downloads available in the full version'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Center(
              child: Semantics(
                button: true,
                label: 'Dispute this bill',
                child: GestureDetector(
                  onTap: () => context.go('/disputes'),
                  child: SizedBox(
                    height: 44,
                    child: Center(
                      child: Text(
                        'Dispute This Bill',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColours.primaryPurple,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColours.textTertiary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.labelLarge.copyWith(
            color: AppColours.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownCard(BillDetails details, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        border: Border.all(color: AppColours.borderSubtle),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Breakdown', style: AppTypography.amountMedium),
          const SizedBox(height: 12),
          ...details.lineItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColours.textSecondary,
                      ),
                    ),
                  ),
                  Text(
                    _formatAmount(item.amountInclVat),
                    style: AppTypography.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: AppColours.divider),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTypography.amountMedium.copyWith(fontSize: 15),
              ),
              Text(
                _formatAmount(total),
                style: AppTypography.amountMedium.copyWith(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleTotal(double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.surface,
        border: Border.all(color: AppColours.borderSubtle),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total', style: AppTypography.amountMedium),
          Text(_formatAmount(total), style: AppTypography.amountMedium),
        ],
      ),
    );
  }
}
