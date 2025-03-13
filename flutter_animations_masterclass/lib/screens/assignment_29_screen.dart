import 'package:flutter/material.dart';

class Assignment29Screen extends StatefulWidget {
  const Assignment29Screen({super.key});

  @override
  State<Assignment29Screen> createState() => _Assignment29ScreenState();
}

class _Assignment29ScreenState extends State<Assignment29Screen>
    with TickerProviderStateMixin {
  late final DecorationTween _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(8),
    ),
    end: BoxDecoration(
      color: Colors.red.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
  );

  late final Tween<double> _opacity = Tween<double>(begin: 1, end: 0);
  AnimationController makeAnimationController({
    required Duration duration,
    required Duration reverseDuration,
  }) {
    late final AnimationController animationController = AnimationController(
      vsync: this,
      duration: duration,
      reverseDuration: reverseDuration,
    );

    return animationController;
  }

  List<AnimationController> list = [];

  void start() {
    for (int i = 0; i < 25; i++) {
      Future.delayed(Duration(milliseconds: 80 * (25 - i)), () {
        list[i].forward();
      });
    }
  }

  final Duration _duration = Duration(milliseconds: 80);
  final Duration _reverseDuration = Duration(milliseconds: 2400);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 25; i++) {
      list.add(
        makeAnimationController(
          duration: _duration,
          reverseDuration: _reverseDuration,
        ),
      );
    }

    start();
  }

  @override
  void dispose() {
    for (int i = 0; i < 25; i++) {
      list[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Explicit Animations"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              AnimatedLine(
                list: list,
                opacity: _opacity,
                decoration: _decoration,
                start: i * 5,
                reverse: i % 2 == 1,
                duration: _duration,
                reverseDuration: _reverseDuration,
              ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLine extends StatelessWidget {
  const AnimatedLine({
    super.key,
    required this.list,
    required Tween<double> opacity,
    required DecorationTween decoration,
    required int start,
    required bool reverse,
    required Duration duration,
    required Duration reverseDuration,
  }) : _opacity = opacity,
       _decoration = decoration,
       _start = start,
       _reverse = reverse,
       _duration = duration,
       _reverseDuration = reverseDuration;

  final List<AnimationController> list;
  final Tween<double> _opacity;
  final DecorationTween _decoration;
  final int _start;
  final bool _reverse;
  final Duration _duration;
  final Duration _reverseDuration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        for (AnimationController ctrl
            in _reverse
                ? list.getRange(_start, _start + 5).toList().reversed.toList()
                : list.getRange(_start, _start + 5))
          FadeTransition(
            opacity: _opacity.animate(
              CurvedAnimation(
                parent: ctrl,
                curve: Interval(0.5, 1, curve: Curves.ease),
              ),
            ),
            child: DecoratedBoxTransition(
              decoration: _decoration.animate(
                CurvedAnimation(
                  parent: ctrl,
                  curve: Interval(0.3, 0.7, curve: Curves.ease),
                ),
              )..addListener(() {
                if (ctrl.status == AnimationStatus.completed) {
                  if (ctrl.duration == _duration) {
                    ctrl.reset();
                    ctrl.duration = _reverseDuration;
                    ctrl.forward();
                  } else {
                    {
                      ctrl.reset();
                      ctrl.duration = _duration;
                      ctrl.forward();
                    }
                  }
                }
              }),
              child: const SizedBox(height: 50, width: 50),
            ),
          ),
      ],
    );
  }
}
