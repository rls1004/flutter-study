import 'package:final_project/firebase_options.dart';
import 'package:final_project/router.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const FinalProjectApp()));
}

class FinalProjectApp extends ConsumerWidget {
  const FinalProjectApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Flutter Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white /*Color(0xffDFD0B8)*/,
        ),
        scaffoldBackgroundColor: Colors.white, //Color(0xFFF1EEDC),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.diphylleia(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w600,
            ),
          ),

          labelMedium: GoogleFonts.orbit(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size20,
              fontWeight: FontWeight.w600,
            ),
          ),
          labelSmall: GoogleFonts.orbit(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w500,
              letterSpacing: -1,
              wordSpacing: -3,
            ),
          ),
        ),
      ),
    );
  }
}
