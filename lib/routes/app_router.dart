import 'package:go_router/go_router.dart';
import '../screens/onboarding_screen.dart';
import '../screens/home_screen.dart';
import '../screens/dump_details_screen.dart';
import '../screens/trash_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/reminders_screen.dart';
import '../screens/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/dump/:id',
      builder: (context, state) {
        final dumpId = state.pathParameters['id']!;
        return DumpDetailsScreen(dumpId: dumpId);
      },
    ),
    GoRoute(
      path: '/trash',
      builder: (context, state) => const TrashScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/reminders',
      builder: (context, state) => const RemindersScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
