import 'package:flutter/material.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypography.amountMedium,
          ),
          if (actionLabel != null)
            Semantics(
              button: true,
              label: '$actionLabel $title',
              child: GestureDetector(
                onTap: onAction,
                child: Text(
                  actionLabel!,
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColours.primaryPurple,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
