import 'package:flutter/material.dart';
import '../../theme/colours.dart';

class SpuerhundCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;

  const SpuerhundCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
  });

  @override
  State<SpuerhundCard> createState() => _SpuerhundCardState();
}

class _SpuerhundCardState extends State<SpuerhundCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gestureDetector = GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _scaleController.forward() : null,
      onTapUp: widget.onTap != null ? (_) {
        _scaleController.reverse();
        widget.onTap!();
      } : null,
      onTapCancel: widget.onTap != null ? () => _scaleController.reverse() : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: AppColours.surface,
            borderRadius: BorderRadius.circular(16),
            border: widget.borderColor != null
                ? Border(left: BorderSide(color: widget.borderColor!, width: 4))
                : Border.all(color: AppColours.borderSubtle),
          ),
          child: widget.child,
        ),
      ),
    );

    if (widget.onTap != null) {
      return Semantics(
        button: true,
        label: 'Interactive card',
        child: gestureDetector,
      );
    }
    return gestureDetector;
  }
}
