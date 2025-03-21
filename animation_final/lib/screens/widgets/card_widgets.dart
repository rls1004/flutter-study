import 'package:animation_final/consts/data.dart';
import 'package:animation_final/screens/selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ImageCard extends StatelessWidget {
  final int index;
  final double size;
  const ImageCard({super.key, required this.index, required this.size});

  @override
  Widget build(BuildContext context) {
    final fullSize = MediaQuery.of(context).size.width;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: fullSize * 0.5 < size ? 10 : 5,
            spreadRadius: fullSize * 0.5 < size ? 2 : 0,
            offset: Offset(0, fullSize * 0.5 < size ? 8 : 2),
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/covers/${index + 1}.png"),
        ),
      ),
    );
  }
}

class DescribeCard extends StatefulWidget {
  final int index;
  const DescribeCard({super.key, required this.size, required this.index});

  final Size size;

  @override
  State<DescribeCard> createState() => _DescribeCardState();
}

class _DescribeCardState extends State<DescribeCard> {
  double _position = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.size.width * 0.8,
          height: widget.size.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 150),
                Text(
                  stocksTicker[widget.index],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  stocks[widget.index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  stocksSumary[widget.index],
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        GestureDetector(
          onTapDown: (details) {
            _position = 0;
            setState(() {});
          },
          onTapUp: (details) {
            _position = 4;
            setState(() {});
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedScreen(index: widget.index),
              ),
            );
          },
          onTapCancel: () {
            _position = 4;
            setState(() {});
          },
          child: SizedBox(
            height: 60,
            width: widget.size.width * 0.8,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60,
                    width: widget.size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: 40.milliseconds,
                  bottom: _position,
                  child: Container(
                    width: widget.size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "데려가기",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
