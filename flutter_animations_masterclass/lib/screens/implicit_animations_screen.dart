import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;
  void trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: ColorTween(begin: Colors.purple, end: Colors.red),
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 10),
              builder: (context, value, child) {
                return Container(width: 40, height: 40, color: value);
              },
            ),
            SizedBox(height: 50),
            ElevatedButton(onPressed: trigger, child: Text("Go!")),
          ],
        ),
      ),
    );
  }
}
