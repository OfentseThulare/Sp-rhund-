import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../theme/colours.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/status_badge.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/staggered_column.dart';
import '../../view_models/account_view_model.dart';
import '../../view_models/bill_view_model.dart';

class BillHistoryScreen extends StatefulWidget {
  const BillHistoryScreen({super.key});

  @override
  State<BillHistoryScreen> createState() => _BillHistoryScreenState();
}

class _BillHistoryScreenState extends State<BillHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final accountVm = context.read<AccountViewModel>();
      if (accountVm.accounts.isNotEmpty) {
        context.read<BillViewModel>().loadBills(accountVm.accounts.first.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final billVm = context.watch<BillViewModel>();
    final formatter = NumberFormat.currency(locale: 'en_ZA', symbol: 'R');

    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        title: const Text('Bills'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: billVm.isLoading
                ? ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpuerhundSpacing.lg,
                      vertical: SpuerhundSpacing.md,
                    ),
                    children: List.generate(
                      5,
                      (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListItemSkeleton(),
                      ),
                    ),
                  )
                : billVm.bills.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpuerhundSpacing.lg,
                          vertical: SpuerhundSpacing.md,
                        ).copyWith(bottom: 120),
                        itemCount: billVm.bills.length,
                        itemBuilder: (context, index) {
                          final bill = billVm.bills[index];
                          return FadeSlideIn(
                            delay: Duration(milliseconds: index * 60),
                            child: GestureDetector(
                              onTap: () =>
                                  context.push('/bill-detail', extra: bill),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: SpuerhundColours.surface,
                                  borderRadius: BorderRadius.circular(
                                      SpuerhundRadius.lg),
                                  border: Border.all(
                                      color: SpuerhundColours.border),
                                  boxShadow: SpuerhundShadows.subtle,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: SpuerhundColours.primaryTint,
                                        borderRadius: BorderRadius.circular(
                                            SpuerhundRadius.sm),
                                      ),
                                      child: const Icon(
                                          Icons.receipt_long_rounded,
                                          color: SpuerhundColours.primary,
                                          size: 22),
                                    ),
                                    const SizedBox(width: SpuerhundSpacing.md),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bill.period,
                                            style: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Due ${DateFormat('dd MMM yyyy').format(bill.dueDate)}',
                                            style: GoogleFonts.manrope(
                                              color: SpuerhundColours
                                                  .textSecondary,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          formatter.format(bill.totalAmount),
                                          style: GoogleFonts.epilogue(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        StatusBadge(status: bill.status),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: SpuerhundNavBar(currentIndex: 1),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpuerhundSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 56, color: SpuerhundColours.textTertiary),
            const SizedBox(height: SpuerhundSpacing.md),
            Text(
              'No bills yet',
              style: GoogleFonts.epilogue(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: SpuerhundColours.textPrimary,
              ),
            ),
            const SizedBox(height: SpuerhundSpacing.sm),
            Text(
              'Bills will appear here once your account is linked and the municipality issues them.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: SpuerhundColours.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
