import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/status_badge.dart';

class DisputesListScreen extends StatefulWidget {
  const DisputesListScreen({super.key});

  @override
  State<DisputesListScreen> createState() => _DisputesListScreenState();
}

class _DisputesListScreenState extends State<DisputesListScreen> {
  int _selectedFilter = 0;

  static const List<String> _filterLabels = ['All', 'Open', 'Resolved'];

  static const List<_MockDispute> _allDisputes = [
    _MockDispute(
      id: 'WD-2026-0041',
      service: 'Water',
      status: 'Under Review',
      statusColour: AppColours.amber,
      date: '12 Mar 2026',
      reason: 'Incorrect meter reading',
    ),
    _MockDispute(
      id: 'ED-2026-0023',
      service: 'Electricity',
      status: 'In Progress',
      statusColour: AppColours.primaryPurple,
      date: '28 Feb 2026',
      reason: 'Estimated billing dispute',
    ),
    _MockDispute(
      id: 'RT-2025-0089',
      service: 'Rates & Taxes',
      status: 'Resolved',
      statusColour: AppColours.emerald,
      date: '15 Dec 2025',
      reason: 'Property valuation challenge',
    ),
  ];

  List<_MockDispute> get _filteredDisputes {
    switch (_selectedFilter) {
      case 1:
        return _allDisputes.where((d) => d.status != 'Resolved').toList();
      case 2:
        return _allDisputes.where((d) => d.status == 'Resolved').toList();
      default:
        return _allDisputes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final disputes = _filteredDisputes;

    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Semantics(
                header: true,
                child: Text(
                  'Disputes',
                  style: AppTypography.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: List.generate(_filterLabels.length, (index) {
                  final isActive = _selectedFilter == index;
                  return Padding(
                    padding: EdgeInsets.only(right: index < _filterLabels.length - 1 ? 8 : 0),
                    child: Semantics(
                      button: true,
                      label: 'Filter ${_filterLabels[index]} disputes',
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFilter = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isActive ? AppColours.primaryPurple : AppColours.surface,
                          borderRadius: BorderRadius.circular(100),
                          border: isActive
                              ? null
                              : Border.all(color: AppColours.borderLight),
                        ),
                        child: Text(
                          _filterLabels[index],
                          style: AppTypography.labelLarge.copyWith(
                            color: isActive
                                ? AppColours.textPrimary
                                : AppColours.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            // Dispute list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: disputes.length,
                itemBuilder: (context, index) {
                  final dispute = disputes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Semantics(
                      button: true,
                      label: 'View dispute details',
                      child: GestureDetector(
                        onTap: () => context.push('/disputes/$index'),
                        child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColours.surface,
                          border: Border.all(color: AppColours.borderSubtle),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dispute.id,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColours.textTertiary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    dispute.service,
                                    style: AppTypography.amountMedium.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    dispute.reason,
                                    style: AppTypography.bodySmall.copyWith(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                StatusBadge(
                                  label: dispute.status,
                                  color: dispute.statusColour,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  dispute.date,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColours.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MockDispute {
  final String id;
  final String service;
  final String status;
  final Color statusColour;
  final String date;
  final String reason;

  const _MockDispute({
    required this.id,
    required this.service,
    required this.status,
    required this.statusColour,
    required this.date,
    required this.reason,
  });
}
