import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../theme/colours.dart';
import '../../models/bill.dart';
import '../../widgets/status_badge.dart';
import '../../widgets/staggered_column.dart';

class BillDetailScreen extends StatelessWidget {
  final Bill bill;

  const BillDetailScreen({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'en_ZA', symbol: 'R');

    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(bill.period),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: SpuerhundSpacing.md),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: SpuerhundColours.surfaceMuted,
              borderRadius: BorderRadius.circular(SpuerhundRadius.sm),
            ),
            child: IconButton(
              icon: const Icon(Icons.download_rounded, size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SpuerhundSpacing.lg),
          child: StaggeredColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Total amount hero
              Center(
                child: Column(
                  children: [
                    Text(
                      'Total Amount Due',
                      style: GoogleFonts.manrope(
                        color: SpuerhundColours.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: SpuerhundSpacing.sm),
                    Text(
                      formatter.format(bill.totalAmount),
                      style: GoogleFonts.epilogue(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -2,
                        color: SpuerhundColours.textPrimary,
                      ),
                    ),
                    const SizedBox(height: SpuerhundSpacing.md),
                    StatusBadge(status: bill.status),
                  ],
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.xxl),

              // Bill Summary
              Text(
                'Bill Summary',
                style: GoogleFonts.epilogue(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: SpuerhundColours.textPrimary,
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.md),
              Container(
                padding: const EdgeInsets.all(SpuerhundSpacing.lg),
                decoration: BoxDecoration(
                  color: SpuerhundColours.surface,
                  borderRadius: BorderRadius.circular(SpuerhundRadius.lg),
                  border: Border.all(color: SpuerhundColours.border),
                  boxShadow: SpuerhundShadows.subtle,
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Issue Date',
                        DateFormat('dd MMM yyyy').format(bill.issuedDate)),
                    Divider(
                        height: SpuerhundSpacing.lg,
                        color: SpuerhundColours.divider),
                    _buildSummaryRow('Due Date',
                        DateFormat('dd MMM yyyy').format(bill.dueDate)),
                    Divider(
                        height: SpuerhundSpacing.lg,
                        color: SpuerhundColours.divider),
                    _buildSummaryRow(
                        'Services Billed', '${bill.serviceCount} services'),
                  ],
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.xl),

              // Services Breakdown
              Text(
                'Services Breakdown',
                style: GoogleFonts.epilogue(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: SpuerhundColours.textPrimary,
                ),
              ),
              const SizedBox(height: SpuerhundSpacing.md),
              Container(
                padding: const EdgeInsets.all(SpuerhundSpacing.lg),
                decoration: BoxDecoration(
                  color: SpuerhundColours.surface,
                  borderRadius: BorderRadius.circular(SpuerhundRadius.lg),
                  border: Border.all(color: SpuerhundColours.border),
                  boxShadow: SpuerhundShadows.subtle,
                ),
                child: Column(
                  children: [
                    _buildServiceItem(Icons.bolt_rounded, 'Electricity',
                        formatter.format(1842.30)),
                    Divider(
                        height: SpuerhundSpacing.lg,
                        color: SpuerhundColours.divider),
                    _buildServiceItem(Icons.water_drop_rounded,
                        'Water & Sanitation', formatter.format(1256.00)),
                    Divider(
                        height: SpuerhundSpacing.lg,
                        color: SpuerhundColours.divider),
                    _buildServiceItem(Icons.receipt_long_rounded,
                        'Rates & Taxes', formatter.format(1234.20)),
                    Divider(
                        height: SpuerhundSpacing.lg,
                        color: SpuerhundColours.divider),
                    _buildServiceItem(Icons.delete_rounded,
                        'Waste Management', formatter.format(500.00)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            color: SpuerhundColours.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w600,
            color: SpuerhundColours.textPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceItem(IconData icon, String label, String amount) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: SpuerhundColours.surfaceMuted,
            borderRadius: BorderRadius.circular(SpuerhundRadius.xs),
          ),
          child: Icon(icon, color: SpuerhundColours.primary, size: 20),
        ),
        const SizedBox(width: SpuerhundSpacing.md),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.manrope(
              color: SpuerhundColours.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.epilogue(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}
