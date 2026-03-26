import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/colours.dart';

class SpurhundApp extends StatelessWidget {
  const SpurhundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp.router(
        title: 'Spürhund',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        routerConfig: appRouter,
        builder: (context, child) {
          return _DesktopFrame(child: child ?? const SizedBox.shrink());
        },
      ),
    );
  }
}

class _DesktopFrame extends StatelessWidget {
  final Widget child;
  const _DesktopFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // On phone-sized screens, render normally
    if (width <= 480) return child;

    // On desktop/tablet, centre the app in a phone-width container
    return Container(
      color: const Color(0xFF050505),
      child: Center(
        child: Container(
          width: 420,
          decoration: BoxDecoration(
            color: AppColours.voidBlack,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColours.primaryPurple.withValues(alpha: 0.08),
                blurRadius: 80,
                spreadRadius: 20,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ),
    );
  }
}
