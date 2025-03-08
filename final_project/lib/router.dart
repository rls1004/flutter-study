import 'package:final_project/data/repos/authentication_repo.dart';
import 'package:final_project/views/analysis/analysis_screen.dart';
import 'package:final_project/views/home/home_screen.dart';
import 'package:final_project/views/main_navigation_screen.dart';
import 'package:final_project/views/noting_screens.dart';
import 'package:final_project/views/profile/profile_screen.dart';
import 'package:final_project/views/profile/setting/setting_screen.dart';
import 'package:final_project/views/signin/signin_screen.dart';
import 'package:final_project/views/signup/signup_date_screen.dart';
import 'package:final_project/views/signup/signup_email_screen.dart';
import 'package:final_project/views/signup/signup_finish_screen.dart';
import 'package:final_project/views/signup/signup_goal_screen.dart';
import 'package:final_project/views/signup/signup_survey_screen.dart';
import 'package:final_project/views/signup/signup_gender_screen.dart';
import 'package:final_project/views/signup/signup_password_screen.dart';
import 'package:final_project/views/signup/signup_username_screen.dart';
import 'package:final_project/views/start_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  ref.watch(authState);
  return GoRouter(
    routerNeglect: false,
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (!state.subloc.contains("/signup") && state.subloc != "/signin") {
          return "/start";
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: StartScreen.routeName,
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: SigninScreen.routeName,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: SignupEmailScreen.routeName,
        builder: (context, state) => SignupEmailScreen(),
      ),
      GoRoute(
        path: SignupPasswordScreen.routeName,
        builder: (context, state) => SignupPasswordScreen(),
      ),
      GoRoute(
        path: SignupGenderScreen.routeName,
        builder: (context, state) => const SignupGenderScreen(),
      ),
      GoRoute(
        path: SignupDateScreen.routeName,
        builder: (context, state) => SignupDateScreen(),
      ),
      GoRoute(
        path: SignupSurveyScreen.routeName,
        builder: (context, state) => SignupSurveyScreen(),
      ),
      GoRoute(
        path: SignupGoalScreen.routeName,
        builder: (context, state) => SignupGoalScreen(),
      ),
      GoRoute(
        path: SignupUsernameScreen.routeName,
        builder: (context, state) => SignupUsernameScreen(),
      ),
      GoRoute(
        path: SignupFinishScreen.routeName,
        builder: (context, state) => SignupFinishScreen(),
      ),

      ShellRoute(
        // navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: MainNavigationScreen(child: child));
        },
        routes: [
          GoRoute(
            path: HomeScreen.routeName,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AnalysisScreen.routeName,
            builder: (context, state) => const AnalysisScreen(),
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
            path: NothingScreens.routeName,
            builder: (context, state) => const NothingScreens(),
          ),
        ],
      ),
    ],
  );
});
