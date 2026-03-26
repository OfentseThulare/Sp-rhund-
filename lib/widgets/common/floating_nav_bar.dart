import 'package:flutter/material.dart';
import '../../theme/colours.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _icons = [
    Icons.home_rounded,
    Icons.explore_rounded,
    Icons.gavel_rounded,
    Icons.phone_rounded,
    Icons.person_rounded,
  ];

  static const _labels = [
    'Home tab',
    'Area tab',
    'Disputes tab',
    'Contacts tab',
    'Profile tab',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: const Color(0xCC0A0A0A),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColours.borderSubtle),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_icons.length, (i) {
            final isActive = i == currentIndex;
            return Semantics(
              button: true,
              label: _labels[i],
              selected: isActive,
              child: GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 56,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      scale: isActive ? 1.15 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutBack,
                      child: Icon(
                        _icons[i],
                        color: isActive
                            ? AppColours.primaryPurple
                            : AppColours.pureWhite.withValues(alpha: 0.4),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: isActive ? 4 : 0,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: AppColours.primaryPurple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            );
          }),
        ),
      ),
    );
  }
}
