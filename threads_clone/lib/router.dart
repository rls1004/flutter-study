import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/screens/activity_screen.dart';
import 'package:threads_clone/screens/home_screen.dart';
import 'package:threads_clone/screens/main_navigation_screen.dart';
import 'package:threads_clone/screens/profile/privacy_screen.dart';
import 'package:threads_clone/screens/profile/setting_screen.dart';
import 'package:threads_clone/screens/profile_screen.dart';
import 'package:threads_clone/screens/search_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routerNeglect: false,
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
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
          builder: (context, state) => const ProfileScreen(userName: "Jane"),
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
