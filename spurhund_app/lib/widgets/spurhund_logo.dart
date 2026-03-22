import 'package:flutter/material.dart';
import '../theme/colours.dart';

/// Spürhund brand logo — dark background with red accent and white hound.
/// Blends seamlessly into the dark theme. Optional rounded container with
/// a subtle purple glow shadow for premium presence.
class SpuerhundLogo extends StatelessWidget {
  final double size;
  final bool showContainer;
  final double containerBorderRadius;

  const SpuerhundLogo({
    super.key,
    this.size = 80,
    this.showContainer = true,
    this.containerBorderRadius = SpuerhundRadius.xl,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(containerBorderRadius),
      child: Image.asset(
        'assets/images/spurhund_logo.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );

    if (!showContainer) return imageWidget;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerBorderRadius),
        boxShadow: [
          BoxShadow(
            color: SpuerhundColours.primary.withValues(alpha: 0.25),
            blurRadius: 32,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      child: imageWidget,
    );
  }
}
