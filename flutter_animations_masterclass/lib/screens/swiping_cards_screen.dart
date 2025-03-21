import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );
  double posX = 0;

  late final Tween<double> _rotation = Tween(begin: -15, end: 15);
  late final Tween<double> _scale = Tween(begin: 0.8, end: 1);

  void _onHorisontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 100;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      final factor = _position.value.isNegative ? -1 : 1;
      _position
          .animateTo(dropZone * factor, curve: Curves.bounceOut)
          .whenComplete(() {
            _position.value = 0;
            setState(() {
              _index = _index == 4 ? 0 : _index + 1;
            });
          });
    } else {
      _position.animateTo(0, curve: Curves.bounceOut);
    }
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Swiping Cards")),
      body: AnimatedBuilder(
        animation: _position,

        builder: (context, child) {
          final angle =
              _rotation.transform(
                (_position.value / 2 + size.width / 2) / (size.width),
              ) *
              pi /
              180;
          final scale = _scale.transform(_position.value.abs() / size.width);
          return Stack(
            alignment: Alignment.topCenter,

            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: min(scale, 1.0),
                  child: Card(index: _index == 4 ? 0 : _index + 1),
                ),
              ),

              Positioned(
                top: 100,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorisontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle,
                      child: Card(index: _index),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;
  const Card({super.key, required this.index});

  static const List<Color> colors = [
    Colors.brown,
    Colors.lightGreen,
    Colors.lightBlue,
    Colors.deepPurple,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.5,
        color: colors[index],
      ),
    );
  }
}
