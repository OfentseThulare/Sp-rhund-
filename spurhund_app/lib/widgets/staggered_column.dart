import 'package:flutter/material.dart';
import '../theme/colours.dart';

/// Staggered animation wrapper that fades and slides children in sequentially.
/// Implements taste-skill "staggerChildren" waterfall reveal pattern.
/// Each child slides up from translate-y-16 with a staggered delay.
class StaggeredColumn extends StatefulWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final Duration staggerDelay;
  final Duration itemDuration;
  final double slideOffset;

  const StaggeredColumn({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.staggerDelay = const Duration(milliseconds: 60),
    this.itemDuration = SpuerhundDurations.normal,
    this.slideOffset = 24,
  });

  @override
  State<StaggeredColumn> createState() => _StaggeredColumnState();
}

class _StaggeredColumnState extends State<StaggeredColumn>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimations();
  }

  void _initAnimations() {
    _controllers = List.generate(
      widget.children.length,
      (index) => AnimationController(
        vsync: this,
        duration: widget.itemDuration,
      ),
    );

    _fadeAnimations = _controllers
        .map((c) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: c, curve: SpuerhundCurves.gentle),
            ))
        .toList();

    _slideAnimations = _controllers
        .map((c) => Tween<Offset>(
              begin: Offset(0, widget.slideOffset),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: c, curve: SpuerhundCurves.premium),
            ))
        .toList();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.staggerDelay * i, () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void didUpdateWidget(StaggeredColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children.length != widget.children.length) {
      for (final c in _controllers) {
        c.dispose();
      }
      _initAnimations();
      _startAnimations();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: List.generate(widget.children.length, (index) {
        if (index >= _controllers.length) return widget.children[index];
        return AnimatedBuilder(
          animation: _controllers[index],
          builder: (context, child) {
            return Transform.translate(
              offset: _slideAnimations[index].value,
              child: Opacity(
                opacity: _fadeAnimations[index].value,
                child: child,
              ),
            );
          },
          child: widget.children[index],
        );
      }),
    );
  }
}

/// Animated list item wrapper for individual staggered items.
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SpuerhundDurations.normal,
    this.slideOffset = 20,
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: SpuerhundCurves.gentle),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: SpuerhundCurves.premium),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
