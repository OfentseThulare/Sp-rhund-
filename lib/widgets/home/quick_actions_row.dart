import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';

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
          color: AppColours.ash,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment feature coming soon'),
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
          icon: Icons.contacts_outlined,
          label: 'Contacts',
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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color == AppColours.ash ? AppColours.ash : AppColours.nearBlack,
            ),
          ),
        ],
      ),
    );
  }
}
