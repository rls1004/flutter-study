import 'package:flutter/material.dart';

class NothingScreens extends StatefulWidget {
  static const routeName = "/nothing";
  const NothingScreens({super.key});

  @override
  State<NothingScreens> createState() => _NothingScreensState();
}

class _NothingScreensState extends State<NothingScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("To be continue...")));
  }
}
