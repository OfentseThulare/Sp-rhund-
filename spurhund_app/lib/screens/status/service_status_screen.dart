import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../theme/colours.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/staggered_column.dart';
import '../../view_models/status_view_model.dart';

class ServiceStatusScreen extends StatefulWidget {
  const ServiceStatusScreen({super.key});

  @override
  State<ServiceStatusScreen> createState() => _ServiceStatusScreenState();
}

class _ServiceStatusScreenState extends State<ServiceStatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatusViewModel>().loadAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusVm = context.watch<StatusViewModel>();

    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        title: const Text('Service Status'),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: statusVm.isLoading
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
                : statusVm.alerts.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpuerhundSpacing.lg,
                          vertical: SpuerhundSpacing.md,
                        ).copyWith(bottom: 120),
                        itemCount: statusVm.alerts.length,
                        itemBuilder: (context, index) {
                          final alert = statusVm.alerts[index];
                          return FadeSlideIn(
                            delay: Duration(milliseconds: index * 60),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: _getBgColor(alert.severity),
                                borderRadius: BorderRadius.circular(
                                    SpuerhundRadius.lg),
                                border: Border.all(
                                    color: _getBorderColor(alert.severity)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            _getIcon(alert.alertType),
                                            color: _getIconColor(
                                                alert.severity),
                                            size: 18,
                                          ),
                                          const SizedBox(
                                              width: SpuerhundSpacing.sm),
                                          Text(
                                            alert.area,
                                            style: GoogleFonts.manrope(
                                              color: SpuerhundColours
                                                  .textSecondary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        DateFormat('dd MMM hh:mm a')
                                            .format(alert.createdAt),
                                        style: GoogleFonts.manrope(
                                          color:
                                              SpuerhundColours.textTertiary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      height: SpuerhundSpacing.sm + 4),
                                  Text(
                                    alert.title,
                                    style: GoogleFonts.epilogue(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: SpuerhundColours.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: SpuerhundSpacing.sm),
                                  Text(
                                    alert.description,
                                    style: GoogleFonts.manrope(
                                      color:
                                          SpuerhundColours.textSecondary,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: SpuerhundNavBar(currentIndex: 2),
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
            Icon(Icons.check_circle_outline_rounded,
                size: 56, color: SpuerhundColours.success),
            const SizedBox(height: SpuerhundSpacing.md),
            Text(
              'All services operational',
              style: GoogleFonts.epilogue(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: SpuerhundColours.textPrimary,
              ),
            ),
            const SizedBox(height: SpuerhundSpacing.sm),
            Text(
              'No active alerts or outages in your area. You will be notified if anything changes.',
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

  Color _getBgColor(String severity) {
    return switch (severity) {
      'critical' => SpuerhundColours.errorTint,
      'warning' => SpuerhundColours.warningTint,
      'info' => SpuerhundColours.primaryTint,
      'resolved' => SpuerhundColours.successTint,
      _ => SpuerhundColours.surface,
    };
  }

  Color _getBorderColor(String severity) {
    return switch (severity) {
      'critical' => SpuerhundColours.error.withValues(alpha: 0.2),
      'warning' => SpuerhundColours.warning.withValues(alpha: 0.2),
      'info' => SpuerhundColours.primary.withValues(alpha: 0.2),
      'resolved' => SpuerhundColours.success.withValues(alpha: 0.2),
      _ => SpuerhundColours.border,
    };
  }

  Color _getIconColor(String severity) {
    return switch (severity) {
      'critical' => SpuerhundColours.error,
      'warning' => SpuerhundColours.warning,
      'info' => SpuerhundColours.primary,
      'resolved' => SpuerhundColours.success,
      _ => SpuerhundColours.textSecondary,
    };
  }

  IconData _getIcon(String alertType) {
    return switch (alertType.toLowerCase()) {
      'water' || 'maintenance' => Icons.water_drop_rounded,
      'electricity' || 'loadshedding' => Icons.bolt_rounded,
      'resolved' => Icons.check_circle_outline_rounded,
      _ => Icons.info_outline_rounded,
    };
  }
}
