import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 2000),
  )..forward();

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );
  late Animation<double> _progress = Tween(
    begin: 0.005,
    end: 1.5,
  ).animate(_curve);

  void _animatedVAlues() {
    final newBegin = _progress.value;
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;
    final newTween = Tween(begin: newBegin, end: newEnd);
    setState(() {
      _progress = newTween.animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Apple Watch"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _progress,
          builder: (context, child) {
            return CustomPaint(
              painter: AppleWatchPainter(progress: _progress.value),
              size: Size(400, 400),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animatedVAlues,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;

  AppleWatchPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final redCircleRadius = (size.width / 2) * 0.9;
    final greenCircleRadius = (size.width / 2) * 0.76;
    final blueCircleRadius = (size.width / 2) * 0.62;

    final startingAngle = -0.5 * pi;

    final redCirclePaint =
        Paint()
          ..color = Colors.red.shade400.withOpacity(0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25;
    canvas.drawCircle(center, redCircleRadius, redCirclePaint);

    final greenCirclePaint =
        Paint()
          ..color = Colors.green.shade400.withOpacity(0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25;
    canvas.drawCircle(center, (size.width / 2) * 0.76, greenCirclePaint);

    final blueCirclePaint =
        Paint()
          ..color = Colors.cyan.shade400.withOpacity(0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25;
    canvas.drawCircle(center, (size.width / 2) * 0.62, blueCirclePaint);

    final redArchRect = Rect.fromCircle(
      center: center,
      radius: redCircleRadius,
    );
    final redArchPaint =
        Paint()
          ..color = Colors.red.shade400
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;
    canvas.drawArc(
      redArchRect,
      startingAngle,
      progress * pi,
      false,
      redArchPaint,
    );

    final greenArchRect = Rect.fromCircle(
      center: center,
      radius: greenCircleRadius,
    );
    final greenArchPaint =
        Paint()
          ..color = Colors.green.shade400
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;
    canvas.drawArc(
      greenArchRect,
      startingAngle,
      progress * pi,
      false,
      greenArchPaint,
    );

    final blueArchRect = Rect.fromCircle(
      center: center,
      radius: blueCircleRadius,
    );
    final blueArchPaint =
        Paint()
          ..color = Colors.cyan.shade400
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;
    canvas.drawArc(
      blueArchRect,
      startingAngle,
      progress * pi,
      false,
      blueArchPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
