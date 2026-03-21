import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colours.dart';

/// Premium glass-morphism card with optional double-bezel (Doppelrand) technique.
/// Implements taste-skill haptic micro-aesthetics: outer shell + inner core
/// with refraction borders and tinted diffusion shadows.
class GlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final bool isDoubleBezel;
  final Color? backgroundColor;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = SpuerhundRadius.xl,
    this.padding = const EdgeInsets.all(24.0),
    this.onTap,
    this.isDoubleBezel = false,
    this.backgroundColor,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: SpuerhundDurations.micro,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _pressController, curve: SpuerhundCurves.snappy),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? Colors.white.withValues(alpha: 0.75);

    Widget card = widget.isDoubleBezel
        ? _buildDoubleBezelCard(bgColor)
        : _buildStandardCard(bgColor);

    if (widget.onTap != null) {
      card = AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: GestureDetector(
          onTapDown: (_) => _pressController.forward(),
          onTapUp: (_) {
            _pressController.reverse();
            widget.onTap?.call();
          },
          onTapCancel: () => _pressController.reverse(),
          behavior: HitTestBehavior.opaque,
          child: card,
        ),
      );
    }

    return card;
  }

  Widget _buildDoubleBezelCard(Color bgColor) {
    // Outer shell: subtle background, hairline border, padding
    return Container(
      decoration: BoxDecoration(
        color: SpuerhundColours.surfaceMuted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(widget.borderRadius + 6),
        border: Border.all(
          color: SpuerhundColours.border,
          width: 1,
        ),
        boxShadow: SpuerhundShadows.card,
      ),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1,
              ),
              // Inner refraction highlight
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.15),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _buildStandardCard(Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: SpuerhundShadows.card,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
