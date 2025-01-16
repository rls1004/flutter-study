import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_pomo.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 212, 77, 59),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.red.shade200,
          ),
          bodyLarge: const TextStyle(
            color: Color.fromARGB(255, 212, 77, 59),
          ),
          bodyMedium: TextStyle(
            color: Colors.red.shade200,
          ),
          bodySmall: const TextStyle(
            color: Colors.white,
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomePomo(),
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
