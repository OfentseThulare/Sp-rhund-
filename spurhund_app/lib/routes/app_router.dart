import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/signup/signup_province_screen.dart';
import '../screens/signup/signup_details_screen.dart';
import '../screens/signup/link_accounts_screen.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard/home_dashboard_screen.dart';
import '../screens/bills/bill_history_screen.dart';
import '../screens/bills/bill_detail_screen.dart';
import '../screens/status/service_status_screen.dart';
import '../screens/disputes/disputes_list_screen.dart';
import '../screens/contacts/contacts_directory_screen.dart';
import '../screens/profile/profile_settings_screen.dart';
import '../models/bill.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/signup-province',
        builder: (context, state) => const SignupProvinceScreen(),
      ),
      GoRoute(
        path: '/signup-details',
        builder: (context, state) => const SignupDetailsScreen(),
      ),
      GoRoute(
        path: '/link-accounts',
        builder: (context, state) => const LinkAccountsScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const HomeDashboardScreen(),
      ),
      GoRoute(
        path: '/bills',
        builder: (context, state) => const BillHistoryScreen(),
      ),
      GoRoute(
        path: '/bill-detail',
        builder: (context, state) {
          final bill = state.extra as Bill?;
          if (bill == null) return const BillHistoryScreen(); // Fallback
          return BillDetailScreen(bill: bill);
        },
      ),
      GoRoute(
        path: '/status',
        builder: (context, state) => const ServiceStatusScreen(),
      ),
      GoRoute(
        path: '/disputes',
        builder: (context, state) => const DisputesListScreen(),
      ),
      GoRoute(
        path: '/contacts',
        builder: (context, state) => const ContactsDirectoryScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileSettingsScreen(),
      ),
    ],
  );
}
