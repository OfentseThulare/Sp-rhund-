import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/common/spuerhund_button.dart';

class BillDetailScreen extends StatelessWidget {
  final String billId;

  const BillDetailScreen({super.key, required this.billId});

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
            _buildServiceHeader(),
            const SizedBox(height: 24),
            _buildInfoRow(),
            const SizedBox(height: 24),
            _buildBreakdownCard(),
            const SizedBox(height: 24),
            _buildPaymentStatus(),
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

  Widget _buildServiceHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColours.info.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.water_drop_rounded,
            color: AppColours.info,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Water',
              style: AppTypography.headlineMedium,
            ),
            const SizedBox(height: 2),
            Text(
              'ACC-TSH-2026-0847',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColours.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        Expanded(
          child: _infoColumn('Bill Period', '1\u201331 Mar 2026'),
        ),
        Expanded(
          child: _infoColumn('Issue Date', '1 Mar 2026'),
        ),
        Expanded(
          child: _infoColumn('Due Date', '15 Apr 2026'),
        ),
      ],
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

  Widget _buildBreakdownCard() {
    const lineItems = [
      ('Basic charge', 'R 125.00'),
      ('Usage (14kL)', 'R 267.78'),
      ('Sanitation levy', 'R 34.00'),
      ('VAT (15%)', 'R 30.00'),
    ];

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
          Text(
            'Breakdown',
            style: AppTypography.amountMedium,
          ),
          const SizedBox(height: 12),
          ...lineItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.$1,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColours.textSecondary,
                    ),
                  ),
                  Text(
                    item.$2,
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
                style: AppTypography.amountMedium.copyWith(
                  fontSize: 15,
                ),
              ),
              Text(
                'R 456.78',
                style: AppTypography.amountMedium.copyWith(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStatus() {
    return StatusBadge.unpaid();
  }
}
