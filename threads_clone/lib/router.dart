import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/activities/views/activity_screen.dart';
import 'package:threads_clone/features/auth/repos/authentication_repo.dart';
import 'package:threads_clone/features/home/views/home_screen.dart';
import 'package:threads_clone/features/auth/login/views/login_screen.dart';
import 'package:threads_clone/features/auth/signup/views/signup_screen.dart';
import 'package:threads_clone/main_navigation_screen.dart';
import 'package:threads_clone/features/profiles/views/settings/privacy_screen.dart';
import 'package:threads_clone/features/profiles/views/settings/setting_screen.dart';
import 'package:threads_clone/features/profiles/views/profile_screen.dart';
import 'package:threads_clone/features/search/views/search_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  ref.watch(authState);
  return GoRouter(
    routerNeglect: false,
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeName &&
            state.subloc != LoginScreen.routeName) {
          return "/login";
        }
      }
      return null;
    },
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: MainNavigationScreen(child: child));
        },
        routes: [
          GoRoute(
            path: HomeScreen.routeName,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: SearchScreen.routeName,
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: ActivityScreen.routeName,
            builder: (context, state) => const ActivityScreen(),
          ),
          GoRoute(
            path: ProfileScreen.routeName,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: SettingScreen.routeName,
            builder: (context, state) => const SettingScreen(),
          ),
          GoRoute(
            path: PrivacyScreen.routeName,
            builder: (context, state) => const PrivacyScreen(),
          ),
        ],
      ),
    ],
  );
});
