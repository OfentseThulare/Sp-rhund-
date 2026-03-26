import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';

class BalanceCard extends StatefulWidget {
  final double totalBalance;
  final DateTime? nextDueDate;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    this.nextDueDate,
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  bool _animationStarted = false;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_animationStarted) {
      _animationStarted = true;
      final reduceMotion = MediaQuery.of(context).disableAnimations;
      if (!reduceMotion) {
        _shimmerController.forward();
      }
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  String get _daysUntilDue {
    if (widget.nextDueDate == null) return '';
    final diff = widget.nextDueDate!.difference(DateTime.now()).inDays;
    if (diff < 0) return 'Overdue';
    if (diff == 0) return 'Due today';
    if (diff == 1) return '1 day';
    return '$diff days';
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_ZA',
      symbol: 'R ',
      decimalDigits: 2,
    );
    final dateFormat = DateFormat('d MMMM yyyy');

    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [AppColours.primaryPurple, AppColours.deepViolet],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.0 + (_shimmerController.value * 0.3),
                1.0,
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColours.primaryPurple.withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              // Subtle inner glow at top-left
              Positioned(
                top: -20,
                left: -20,
                child: IgnorePointer(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card content
              Padding(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount Due',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColours.pureWhite.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currencyFormat.format(widget.totalBalance),
                      style: AppTypography.balanceDisplay,
                    ),
                    if (widget.nextDueDate != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Next due: ${dateFormat.format(widget.nextDueDate!)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColours.pureWhite.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColours.pureWhite.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              _daysUntilDue,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColours.pureWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
