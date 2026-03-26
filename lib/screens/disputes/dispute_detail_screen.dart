import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/status_badge.dart';

class DisputeDetailScreen extends StatefulWidget {
  final String disputeId;
  const DisputeDetailScreen({super.key, required this.disputeId});

  @override
  State<DisputeDetailScreen> createState() => _DisputeDetailScreenState();
}

class _DisputeDetailScreenState extends State<DisputeDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_animationStarted) {
      _animationStarted = true;
      final reduceMotion = MediaQuery.of(context).disableAnimations;
      if (!reduceMotion) {
        _pulseController.repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColours.voidBlack,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColours.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Semantics(
          header: true,
          child: Text(
            'Dispute Details',
            style: AppTypography.headlineSmall,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ID and status row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'WD-2026-0041',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColours.textSecondary,
                  ),
                ),
                const StatusBadge(label: 'Under Review', color: AppColours.amber),
              ],
            ),
            const SizedBox(height: 24),

            // Status Timeline
            _buildTimelineStep(
              label: 'Submitted',
              date: '12 Mar 2026',
              state: _StepState.completed,
              isLast: false,
            ),
            _buildTimelineStep(
              label: 'In Progress',
              date: '15 Mar 2026',
              state: _StepState.completed,
              isLast: false,
            ),
            _buildTimelineStep(
              label: 'Under Review',
              date: '20 Mar 2026',
              state: _StepState.current,
              isLast: false,
            ),
            _buildTimelineStep(
              label: 'Resolved',
              date: null,
              state: _StepState.pending,
              isLast: true,
            ),

            const SizedBox(height: 24),

            // Original Bill Reference
            _buildInfoCard(
              title: 'Original Bill Reference',
              rows: const [
                _InfoRow('Service', 'Water'),
                _InfoRow('Period', 'March 2026'),
                _InfoRow('Amount', 'R 456.78'),
                _InfoRow('Account', 'ACC-TSH-2026-0847'),
              ],
            ),
            const SizedBox(height: 16),

            // Dispute Reason
            _buildTextCard(
              title: 'Dispute Reason',
              body:
                  'Incorrect meter reading. The recorded consumption of 24kL is significantly higher than our typical usage of 12 to 14kL per month. We request a physical meter verification.',
            ),
            const SizedBox(height: 16),

            // Municipality Response
            _buildTextCard(
              title: 'Municipality Response',
              body:
                  'Your dispute has been escalated to the technical team for meter verification. A field inspector will be assigned within 5 working days.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required String label,
    required String? date,
    required _StepState state,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (state == _StepState.current)
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColours.primaryPurple.withValues(alpha: _pulseAnimation.value),
                    ),
                  );
                },
              )
            else
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state == _StepState.completed
                      ? AppColours.emerald
                      : AppColours.surface,
                  border: state == _StepState.pending
                      ? Border.all(color: AppColours.borderLight, width: 1.5)
                      : null,
                ),
              ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: state == _StepState.completed
                    ? AppColours.emerald.withValues(alpha: 0.4)
                    : AppColours.borderSubtle,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelLarge.copyWith(
                    color: state == _StepState.pending
                        ? AppColours.textTertiary
                        : AppColours.textPrimary,
                  ),
                ),
                if (date != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      date,
                      style: AppTypography.bodySmall,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<_InfoRow> rows,
  }) {
    return Container(
      width: double.infinity,
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
            title,
            style: AppTypography.labelLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...rows.asMap().entries.map((entry) {
            final i = entry.key;
            final row = entry.value;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      row.label,
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 13,
                        color: AppColours.textTertiary,
                      ),
                    ),
                    Text(
                      row.value,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColours.textPrimary,
                      ),
                    ),
                  ],
                ),
                if (i < rows.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(height: 1, color: AppColours.divider),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTextCard({
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
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
            title,
            style: AppTypography.labelLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: AppTypography.bodyMedium,
          ),
        ],
      ),
    );
  }
}

enum _StepState { completed, current, pending }

class _InfoRow {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);
}
