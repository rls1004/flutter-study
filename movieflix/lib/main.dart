import 'package:flutter/material.dart';
import 'package:movieflix/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFAEC),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFF578E7E),
            fontWeight: FontWeight.w900,
            fontSize: 33,
          ),
          titleSmall: TextStyle(
            color: Color(0xFF578E7E),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          bodyLarge: TextStyle(
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF3D3D3D),
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
          bodySmall: const TextStyle(
            color: Colors.red,
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: HomeScreen(),
    );
  }
}
