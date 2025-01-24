import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:y/features/authentication/home_screen.dart';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  await initializeDateFormatting('en_US', null);

  runApp(const YApp());
}

class YApp extends StatelessWidget {
  const YApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YApp',
      theme: ThemeData(
          primaryColor: Colors.blue.shade600,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.white,
          )),
      home: HomeScreen(),
    );
  }
}
