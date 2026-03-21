import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../models/dispute.dart';
import '../../view_models/disputes_view_model.dart';
import '../../widgets/common/status_badge.dart';

class DisputeDetailScreen extends StatelessWidget {
  final String disputeId;
  const DisputeDetailScreen({super.key, required this.disputeId});

  @override
  Widget build(BuildContext context) {
    final dispute = context.read<DisputesViewModel>().getById(disputeId);
    if (dispute == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Dispute')),
        body: const Center(child: Text('Dispute not found')),
      );
    }

    final dateFormat = DateFormat('d MMMM yyyy');

    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(dispute.ticketNumber),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _badgeForStatus(dispute.status),
            const SizedBox(height: 16),
            Text(
              dispute.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColours.nearBlack,
              ),
            ),
            const SizedBox(height: 24),
            if (dispute.description != null) ...[
              const Text(
                'Description',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColours.slate),
              ),
              const SizedBox(height: 8),
              Text(
                dispute.description!,
                style: const TextStyle(fontSize: 15, color: AppColours.nearBlack, height: 1.5),
              ),
              const SizedBox(height: 24),
            ],
            _detailRow('Service Type', dispute.serviceType ?? 'N/A'),
            _detailRow('Dispute Type', dispute.disputeType ?? 'N/A'),
            _detailRow('Created', dateFormat.format(dispute.createdAt)),
            if (dispute.updatedAt != null)
              _detailRow('Last Updated', dateFormat.format(dispute.updatedAt!)),
            const SizedBox(height: 32),
            const Text(
              'Timeline',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColours.nearBlack),
            ),
            const SizedBox(height: 16),
            _buildTimeline(dispute),
          ],
        ),
      ),
    );
  }

  Widget _badgeForStatus(DisputeStatus status) {
    Color color;
    switch (status) {
      case DisputeStatus.submitted:
        color = AppColours.slate;
      case DisputeStatus.inProgress:
        color = AppColours.amber;
      case DisputeStatus.underReview:
        color = const Color(0xFF3B82F6);
      case DisputeStatus.resolved:
        color = AppColours.emerald;
    }
    return StatusBadge(label: status.displayName, color: color);
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: AppColours.slate),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColours.nearBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(Dispute dispute) {
    final steps = <_TimelineStep>[
      _TimelineStep('Submitted', dispute.createdAt, true),
    ];

    if (dispute.status == DisputeStatus.inProgress ||
        dispute.status == DisputeStatus.underReview ||
        dispute.status == DisputeStatus.resolved) {
      steps.add(_TimelineStep('In Progress', dispute.updatedAt ?? dispute.createdAt, true));
    }

    if (dispute.status == DisputeStatus.underReview ||
        dispute.status == DisputeStatus.resolved) {
      steps.add(_TimelineStep('Under Review', dispute.updatedAt ?? dispute.createdAt, true));
    }

    if (dispute.status == DisputeStatus.resolved) {
      steps.add(_TimelineStep('Resolved', dispute.updatedAt ?? dispute.createdAt, true));
    }

    // Add pending steps
    if (dispute.status != DisputeStatus.resolved) {
      if (dispute.status == DisputeStatus.submitted) {
        steps.add(const _TimelineStep('In Progress', null, false));
      }
      if (dispute.status == DisputeStatus.submitted ||
          dispute.status == DisputeStatus.inProgress) {
        steps.add(const _TimelineStep('Under Review', null, false));
      }
      steps.add(const _TimelineStep('Resolved', null, false));
    }

    final dateFormat = DateFormat('d MMM yyyy');

    return Column(
      children: steps.asMap().entries.map((entry) {
        final i = entry.key;
        final step = entry.value;
        final isLast = i == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.isComplete ? AppColours.primaryPurple : AppColours.fog,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: step.isComplete ? AppColours.primaryPurple : AppColours.fog,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: step.isComplete ? AppColours.nearBlack : AppColours.ash,
                      ),
                    ),
                    if (step.date != null)
                      Text(
                        dateFormat.format(step.date!),
                        style: const TextStyle(fontSize: 12, color: AppColours.slate),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _TimelineStep {
  final String label;
  final DateTime? date;
  final bool isComplete;

  const _TimelineStep(this.label, this.date, this.isComplete);
}
