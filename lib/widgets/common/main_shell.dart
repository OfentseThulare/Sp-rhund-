import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'floating_nav_bar.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  static const _tabs = [
    '/home',
    '/area',
    '/disputes',
    '/contacts',
    '/profile',
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i])) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);

    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: FloatingNavBar(
        currentIndex: index,
        onTap: (i) => context.go(_tabs[i]),
      ),
    );
  }
}
