import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threads_clone/features/profiles/repos/setting_config_repo.dart';
import 'package:threads_clone/features/profiles/view_models/setting_config_vm.dart';
import 'package:threads_clone/firebase_options.dart';
import 'package:threads_clone/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = SettingConfigRepository(preferences);

  repository.isDarkMode();

  runApp(ProviderScope(
    overrides: [
      settingConfigProvider
          .overrideWith(() => SettingConfigViewModel(repository)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Threads clone',
      themeMode: ref.watch(settingConfigProvider).darkMode
          ? ThemeMode.dark
          : ThemeMode.light, //ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.5),
          elevation: 0,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          elevation: 0,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.black,
        ),
      ),
    );
  }
}
