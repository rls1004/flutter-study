import 'dart:async';

import 'package:flutter/material.dart';

class Assignment28Screen extends StatefulWidget {
  const Assignment28Screen({super.key});

  @override
  State<Assignment28Screen> createState() => _Assignment28ScreenState();
}

class _Assignment28ScreenState extends State<Assignment28Screen> {
  bool _tick = true;
  late Timer _timer;
  final Duration _animatedDuration = Duration(seconds: 1);

  void animatedLoop() {
    _timer = Timer.periodic(Duration(seconds: 0), (timer) {
      setState(() {
        _tick = !_tick;
        timer.cancel();
      });
    });

    _timer = Timer.periodic(_animatedDuration, (timer) {
      setState(() {
        _tick = !_tick;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    animatedLoop();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _tick ? Colors.grey.shade200 : Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: _tick ? Colors.black : Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.width * 0.6,
              width: size.width * 0.6,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: size.width * 0.6,
                    width: size.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(_tick ? 200 : 0),
                    ),
                  ),
                  AnimatedAlign(
                    duration: _animatedDuration,
                    alignment:
                        _tick ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      height: size.width * 0.6,
                      width: 17,
                      decoration: BoxDecoration(
                        color: _tick ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
