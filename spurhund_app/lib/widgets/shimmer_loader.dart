import 'package:flutter/material.dart';
import '../theme/colours.dart';

/// Skeleton shimmer loader replacing generic CircularProgressIndicator.
/// Creates a shifting light reflection across placeholder boxes,
/// matching the layout sizes of actual content.
class ShimmerLoader extends StatefulWidget {
  final Widget child;

  const ShimmerLoader({super.key, required this.child});

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: SpuerhundCurves.gentle),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFFEEEEEE),
                Color(0xFFF8F8F8),
                Color(0xFFEEEEEE),
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((s) => s.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// A single shimmer placeholder box.
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = SpuerhundRadius.sm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: SpuerhundColours.surfaceMuted,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Pre-built shimmer skeleton for a balance card.
class BalanceCardSkeleton extends StatelessWidget {
  const BalanceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: SpuerhundColours.surfaceMuted,
          borderRadius: BorderRadius.circular(SpuerhundRadius.xl),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(width: 160, height: 16),
            const SizedBox(height: 16),
            const ShimmerBox(width: 200, height: 48),
            const SizedBox(height: 24),
            const ShimmerBox(height: 48, borderRadius: SpuerhundRadius.pill),
          ],
        ),
      ),
    );
  }
}

/// Pre-built shimmer skeleton for a list item.
class ListItemSkeleton extends StatelessWidget {
  const ListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: SpuerhundColours.surfaceMuted,
          borderRadius: BorderRadius.circular(SpuerhundRadius.lg),
        ),
        child: Row(
          children: [
            const ShimmerBox(width: 48, height: 48, borderRadius: SpuerhundRadius.md),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBox(width: 120, height: 14),
                  SizedBox(height: 8),
                  ShimmerBox(width: 80, height: 12),
                ],
              ),
            ),
            const ShimmerBox(width: 60, height: 14),
          ],
        ),
      ),
    );
  }
}
