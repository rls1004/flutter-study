import 'dart:ui';
import 'package:animation_final/consts/data.dart';
import 'package:animation_final/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class StockDetailsPage extends StatefulWidget {
  final int index;

  const StockDetailsPage({
    super.key,
    required this.size,
    required this.index,
    required AnimationController upperPageController,
  }) : _upperPageController = upperPageController;

  final Size size;
  final AnimationController _upperPageController;

  @override
  State<StockDetailsPage> createState() => _StockDetailsPageState();
}

class _StockDetailsPageState extends State<StockDetailsPage> {
  late final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -widget.size.height,
      child: Container(
            width: widget.size.width,
            height: widget.size.height * 0.87,
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 22, 18, 18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (_scrollController.position.outOfRange &&
                      _scrollController.position.userScrollDirection ==
                          ScrollDirection.reverse) {
                    widget._upperPageController.reverse().whenComplete(() {
                      _scrollController.animateTo(
                        0.0,
                        duration: 1.milliseconds,
                        curve: Curves.easeInOut,
                      );
                    });
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        stocksTicker[widget.index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        stocks[widget.index],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        stocksDetails[widget.index],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 30),
                      StockChart(priceHistory: pricesOfStock[widget.index]),
                      SizedBox(height: 20),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey,
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Lottie.asset(
                              "assets/animations/fire-lottie.json",
                              width: 70,
                              height: 70,
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var point in stocksPositive[widget.index]
                                  .split(', '))
                                Text(
                                  "- $point",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey,
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          SizedBox(
                            width: 100,
                            child: Lottie.asset(
                              "assets/animations/water-lottie.json",
                              width: 60,
                              height: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var point in stocksNegative[widget.index]
                                  .split(', '))
                                Text(
                                  "- $point",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey,
                        height: 30,
                      ),
                      SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
            ),
          )
          .animate(controller: widget._upperPageController, autoPlay: false)
          .fadeIn()
          .moveY(end: -1)
          .slideY(duration: 500.milliseconds, end: 1.13),
    );
  }
}
