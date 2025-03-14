import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/apple_watch_screen.dart';
import 'package:flutter_animations_masterclass/screens/assignment_28_screen.dart';
import 'package:flutter_animations_masterclass/screens/assignment_29_screen.dart';
import 'package:flutter_animations_masterclass/screens/assignment_30_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicit_animations_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Animations")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, ImplicitAnimationsScreen());
              },
              child: Text("Implicit Animations"),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, Assignment28Screen());
              },
              child: Text("Assignment 28"),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, Assignment29Screen());
              },
              child: Text("Assignment 29"),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, AppleWatchScreen());
              },
              child: Text("Apple Watch"),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, Assignment30Screen());
              },
              child: Text("Assignment 30"),
            ),
          ],
        ),
      ),
    );
  }
}
