import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/colours.dart';

/// Floating glass-morphism navigation bar with animated selection indicator.
/// Implements taste-skill floating pill navbar with premium spring transitions.
class SpuerhundNavBar extends StatelessWidget {
  final int currentIndex;

  const SpuerhundNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        context.go('/dashboard');
      case 1:
        context.go('/bills');
      case 2:
        context.go('/status');
      case 3:
        context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: SpuerhundSpacing.lg,
          vertical: SpuerhundSpacing.md,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SpuerhundRadius.pill),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: SpuerhundColours.surface.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(SpuerhundRadius.pill),
                boxShadow: SpuerhundShadows.floating,
                border: Border.all(
                  color: SpuerhundColours.glassBorder,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavItem(
                    icon: Icons.grid_view_rounded,
                    label: 'Dashboard',
                    isSelected: currentIndex == 0,
                    onTap: () => _onItemTapped(context, 0),
                  ),
                  _NavItem(
                    icon: Icons.receipt_long_rounded,
                    label: 'Bills',
                    isSelected: currentIndex == 1,
                    onTap: () => _onItemTapped(context, 1),
                  ),
                  _NavItem(
                    icon: Icons.bolt_rounded,
                    label: 'Status',
                    isSelected: currentIndex == 2,
                    onTap: () => _onItemTapped(context, 2),
                  ),
                  _NavItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    isSelected: currentIndex == 3,
                    onTap: () => _onItemTapped(context, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: SpuerhundDurations.micro,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _tapController, curve: SpuerhundCurves.snappy),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _tapController.forward(),
      onTapUp: (_) {
        _tapController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _tapController.reverse(),
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: SpuerhundDurations.fast,
          curve: SpuerhundCurves.spring,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSelected ? 20 : 16,
            vertical: 10,
          ),
          decoration: widget.isSelected
              ? BoxDecoration(
                  color: SpuerhundColours.primaryTint,
                  borderRadius: BorderRadius.circular(SpuerhundRadius.pill),
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: SpuerhundDurations.fast,
                child: Icon(
                  widget.icon,
                  key: ValueKey(widget.isSelected),
                  color: widget.isSelected
                      ? SpuerhundColours.primary
                      : SpuerhundColours.textTertiary,
                  size: 24,
                ),
              ),
              if (widget.isSelected) ...[
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: SpuerhundColours.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
