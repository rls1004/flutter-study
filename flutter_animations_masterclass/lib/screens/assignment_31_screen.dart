import 'dart:math';

import 'package:flutter/material.dart';

class Assignment31Screen extends StatefulWidget {
  const Assignment31Screen({super.key});

  @override
  State<Assignment31Screen> createState() => _Assignment31ScreenState();
}

class _Assignment31ScreenState extends State<Assignment31Screen>
    with TickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  double posX = 0;
  bool _isFlipDone = false;

  late final AnimationController _positionController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final AnimationController _flipController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 600),
  )..addListener(() {
    if (_flipController.status == AnimationStatus.completed) {
      setState(() {
        _isFlipDone = true;
      });
    }
  });

  late final AnimationController _progressController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );

  int _index = 0;
  final int _totalChallenge = 5;
  bool _finish = false;

  late final Tween<double> _rotation = Tween(begin: -15, end: 15);
  late final Tween<double> _scale = Tween(begin: 0.8, end: 1);
  late final Tween<double> _opacity = Tween(begin: 0.2, end: 1);
  late final Animation<double> _flip = Tween(
    begin: 0.0,
    end: pi,
  ).animate(_flipController);
  late Animation<double> _progress = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_progressController);

  void _onHorisontalDragUpdate(DragUpdateDetails details) {
    _positionController.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 150;
    final dropZone = size.width + 100;

    if (_positionController.value.abs() >= bound) {
      final factor = _positionController.value.isNegative ? -1 : 1;
      _positionController
          .animateTo(dropZone * factor, curve: Curves.ease)
          .whenComplete(() {
            _positionController.value = 0;
            _flipController.value = 0;

            _progress = Tween(
              begin: _progress.value,
              end: (_index + 1) / _totalChallenge,
            ).animate(_progressController);
            _progressController.forward(from: 0);

            setState(() {
              if (_index == 4) {
                _finish = true;
              }
              _index = _index == 4 ? 0 : _index + 1;
              _isTap = false;
              _isFlipDone = false;
            });
          });
    } else {
      _positionController.animateTo(0, curve: Curves.ease);
    }
  }

  void _onTap() {
    setState(() {
      _isTap = !_isTap;
      _isFlipDone = false;
      if (_isTap) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _positionController.dispose();
    _flipController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  final List<String> _contents = [
    "세계 최초의 프로그래머",
    "버그(Bug) 용어의 시작",
    "최초의 인터넷",
    "최초의 개인용 컴퓨터(PC)",
    "리눅스를 만든 사람",
  ];
  final List<String> _anwser = [
    "에이다 러브레이스",
    "실제 나방(벌레)",
    "ARPANET",
    "Altair 8800",
    "리누스 토발즈",
  ];
  bool _isTap = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _positionController,

      builder: (context, child) {
        final angle =
            _rotation.transform(
              (_positionController.value + size.width) / (2 * size.width),
            ) *
            pi /
            180;
        final scale = _scale.transform(
          _positionController.value.abs() / size.width,
        );
        final opacity = _opacity.transform(
          _positionController.value.abs() / size.width,
        );

        return Scaffold(
          backgroundColor: Color.lerp(
            Colors.lightBlue.shade400,
            _positionController.value.abs() < 20
                ? Colors.lightBlue.shade400
                : _positionController.value.isNegative
                ? Colors.deepOrange.shade400
                : Colors.green.shade400,
            min((_positionController.value.abs() * 3 / size.width), 1),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    _positionController.value.isNegative
                        ? "Need to review"
                        : "I got it now",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(
                        _positionController.value.abs() < 30
                            ? 0
                            : max(
                              min(
                                (_positionController.value *
                                        (_positionController.value.isNegative
                                            ? -5
                                            : 5)) /
                                    size.width,
                                1,
                              ),
                              0,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.5,
                  child:
                      _finish
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("🥳", style: TextStyle(fontSize: 70)),
                                Text(
                                  "All Done!",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : Stack(
                            alignment: Alignment.topCenter,

                            children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                child:
                                    _index < 4
                                        ? Transform.scale(
                                          scale: min(scale, 1.0),
                                          child: Opacity(
                                            opacity: min(opacity, 1.0),
                                            child: Card(
                                              text:
                                                  min(opacity, 1.0) < 0.7
                                                      ? ""
                                                      : _contents[(_index + 1) %
                                                          _totalChallenge],
                                            ),
                                          ),
                                        )
                                        : Container(),
                              ),

                              Positioned(
                                top: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onHorizontalDragUpdate:
                                      _isTap ? _onHorisontalDragUpdate : null,
                                  onHorizontalDragEnd:
                                      _isTap ? _onHorizontalDragEnd : null,
                                  onTap: _isTap ? null : _onTap,
                                  child: AnimatedBuilder(
                                    animation: _flip,
                                    builder: (context, child) {
                                      final scale = _scale.transform(
                                        ((_flip.value - pi / 2) / (pi / 2))
                                            .abs(),
                                      );

                                      return Transform.scale(
                                        scale: scale,
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform:
                                              Matrix4.identity()
                                                ..setEntry(3, 2, 0.0012)
                                                ..rotateY(_flip.value),
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(
                                                min(
                                                  0.6,
                                                  1 -
                                                      ((_flip.value - pi / 2) /
                                                              (pi / 2))
                                                          .abs(),
                                                ),
                                              ),
                                              BlendMode.srcATop,
                                            ),
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                                    child: AnimatedDraggableCard(
                                      positionController: _positionController,
                                      isFlipDone: _isFlipDone,
                                      angle: angle,
                                      child:
                                          _isTap
                                              ? Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.identity()
                                                      ..setEntry(3, 2, 0.0012)
                                                      ..rotateY(pi),
                                                child: Card(
                                                  key: ValueKey(
                                                    _anwser[_index %
                                                        _totalChallenge],
                                                  ),
                                                  text:
                                                      _isFlipDone
                                                          ? _anwser[_index %
                                                              _totalChallenge]
                                                          : "",
                                                ),
                                              )
                                              : Card(
                                                key: ValueKey(
                                                  _contents[_index %
                                                      _totalChallenge],
                                                ),
                                                text:
                                                    _isTap && !_isFlipDone
                                                        ? ""
                                                        : _contents[_index %
                                                            _totalChallenge],
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),
                SizedBox(height: 100),
                AnimatedProgressBar(progress: _progress, size: size),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AnimatedDraggableCard extends StatelessWidget {
  const AnimatedDraggableCard({
    super.key,
    required this.positionController,
    required this.isFlipDone,
    required this.angle,
    required this.child,
  });

  final AnimationController positionController;
  final bool isFlipDone;
  final double angle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(positionController.value * (isFlipDone ? -1 : 1), 0),
      child: Transform.rotate(
        angle: angle * (isFlipDone ? -1 : 1),
        child: child,
      ),
    );
  }
}

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    super.key,
    required Animation<double> progress,
    required this.size,
  }) : _progress = progress;

  final Animation<double> _progress;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) {
        return CustomPaint(
          painter: ProgressPainter(progress: _progress.value),
          size: Size(size.width - 100, 10),
        );
      },
    );
  }
}

class Card extends StatelessWidget {
  final String text;
  const Card({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(30),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.5,
        color: Colors.white,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  late final double progress;
  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPath =
        Paint()
          ..color = Colors.black.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round;

    Path background = Path();
    background.moveTo(0, 0);
    background.lineTo(size.width * 1, 0);
    canvas.drawPath(background, backgroundPath);

    Paint foregroundPath =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round;

    Path foreground = Path();
    foreground.moveTo(0, 0);
    foreground.lineTo(size.width * progress, 0);
    canvas.drawPath(foreground, foregroundPath);
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
