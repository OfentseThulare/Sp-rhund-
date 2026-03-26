import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _QuickAction(
          icon: Icons.payment_rounded,
          label: 'Pay',
          color: AppColours.textTertiary,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment integration available in the full version'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        _QuickAction(
          icon: Icons.receipt_long_rounded,
          label: 'History',
          color: AppColours.primaryPurple,
          onTap: () => context.push('/home/history'),
        ),
        _QuickAction(
          icon: Icons.report_problem_outlined,
          label: 'Report',
          color: AppColours.primaryPurple,
          onTap: () => context.go('/disputes'),
        ),
        _QuickAction(
          icon: Icons.more_horiz_rounded,
          label: 'More',
          color: AppColours.primaryPurple,
          onTap: () => context.go('/contacts'),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = color == AppColours.textTertiary;

    final semanticLabels = const {
      'Pay': 'Pay bills',
      'History': 'View bill history',
      'Report': 'Report an issue',
      'More': 'More options',
    };

    return Semantics(
      button: true,
      label: semanticLabels[label] ?? label,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isDisabled
                  ? AppColours.surface
                  : color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: AppColours.borderSubtle),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: isDisabled ? AppColours.textTertiary : AppColours.textSecondary,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
