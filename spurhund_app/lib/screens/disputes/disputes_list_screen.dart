import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../theme/colours.dart';
import '../../widgets/status_badge.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/staggered_column.dart';
import '../../view_models/dispute_view_model.dart';

class DisputesListScreen extends StatefulWidget {
  const DisputesListScreen({super.key});

  @override
  State<DisputesListScreen> createState() => _DisputesListScreenState();
}

class _DisputesListScreenState extends State<DisputesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DisputeViewModel>().loadDisputes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final disputeVm = context.watch<DisputeViewModel>();

    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('My Disputes'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: SpuerhundSpacing.md),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: SpuerhundColours.primaryTint,
              borderRadius: BorderRadius.circular(SpuerhundRadius.sm),
            ),
            child: IconButton(
              icon: const Icon(Icons.add_rounded,
                  color: SpuerhundColours.primary, size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: disputeVm.isLoading
            ? ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpuerhundSpacing.lg,
                  vertical: SpuerhundSpacing.md,
                ),
                children: List.generate(
                  4,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ListItemSkeleton(),
                  ),
                ),
              )
            : disputeVm.disputes.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpuerhundSpacing.lg,
                      vertical: SpuerhundSpacing.md,
                    ),
                    itemCount: disputeVm.disputes.length,
                    itemBuilder: (context, index) {
                      final dispute = disputeVm.disputes[index];
                      return FadeSlideIn(
                        delay: Duration(milliseconds: index * 60),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(SpuerhundRadius.lg),
                            border: Border.all(color: SpuerhundColours.border),
                            boxShadow: SpuerhundShadows.subtle,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dispute.ticketNumber,
                                    style: GoogleFonts.epilogue(
                                      fontWeight: FontWeight.bold,
                                      color: SpuerhundColours.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  StatusBadge(status: dispute.status),
                                ],
                              ),
                              const SizedBox(height: SpuerhundSpacing.sm + 4),
                              Text(
                                dispute.title,
                                style: GoogleFonts.epilogue(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: SpuerhundColours.textPrimary,
                                ),
                              ),
                              const SizedBox(height: SpuerhundSpacing.xs),
                              Text(
                                'Opened ${DateFormat('dd MMM yyyy').format(dispute.createdAt)}',
                                style: GoogleFonts.manrope(
                                  color: SpuerhundColours.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
            Icon(Icons.gavel_outlined,
                size: 56, color: SpuerhundColours.textTertiary),
            const SizedBox(height: SpuerhundSpacing.md),
            Text(
              'No disputes filed',
              style: GoogleFonts.epilogue(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: SpuerhundColours.textPrimary,
              ),
            ),
            const SizedBox(height: SpuerhundSpacing.sm),
            Text(
              'If you spot a billing error, tap the + button to open a new dispute with your municipality.',
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
