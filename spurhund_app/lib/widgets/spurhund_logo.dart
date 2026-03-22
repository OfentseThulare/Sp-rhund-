import 'package:flutter/material.dart';
import '../theme/colours.dart';

/// The official Spürhund brand logo rendered from the PNG asset.
/// Uses a black background to blend seamlessly into the dark theme.
/// The logo image (white hound on black) is displayed directly
/// inside an optional rounded container.
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
    final imageWidget = Image.asset(
      'assets/images/spurhund_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );

    if (!showContainer) return imageWidget;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: SpuerhundColours.backgroundDark,
        borderRadius: BorderRadius.circular(containerBorderRadius),
        border: Border.all(
          color: SpuerhundColours.border,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: SpuerhundColours.primary.withValues(alpha: 0.20),
            blurRadius: 32,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: imageWidget,
    );
  }
}
