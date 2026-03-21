import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/sign_up_province_screen.dart';
import '../screens/auth/sign_up_details_screen.dart';
import '../screens/link_accounts/link_accounts_screen.dart';
import '../screens/home/dashboard_screen.dart';
import '../screens/home/bill_history_screen.dart';
import '../screens/home/bill_detail_screen.dart';
import '../screens/area/service_status_screen.dart';
import '../screens/disputes/disputes_list_screen.dart';
import '../screens/disputes/dispute_detail_screen.dart';
import '../screens/contacts/contacts_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../widgets/common/main_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/signup/province',
      builder: (context, state) => const SignUpProvinceScreen(),
    ),
    GoRoute(
      path: '/signup/details',
      builder: (context, state) => const SignUpDetailsScreen(),
    ),
    GoRoute(
      path: '/link-accounts',
      builder: (context, state) => const LinkAccountsScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const DashboardScreen(),
          routes: [
            GoRoute(
              path: 'history',
              builder: (context, state) => const BillHistoryScreen(),
            ),
            GoRoute(
              path: 'bill/:id',
              builder: (context, state) =>
                  BillDetailScreen(billId: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: '/area',
          builder: (context, state) => const ServiceStatusScreen(),
        ),
        GoRoute(
          path: '/disputes',
          builder: (context, state) => const DisputesListScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) =>
                  DisputeDetailScreen(disputeId: state.pathParameters['id']!),
            ),
          ],
        ),
        GoRoute(
          path: '/contacts',
          builder: (context, state) => const ContactsScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
