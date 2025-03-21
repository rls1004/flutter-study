import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:animation_final/screens/stock_details_page.dart';
import 'package:animation_final/screens/widgets/card_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  final PageController _pageController = PageController(viewportFraction: 0.78);

  int _currentPage = 0;
  bool isUpperPage = false;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _position.dispose();
    _upperPageController.dispose();
    super.dispose();
  }

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: 2.seconds,
    lowerBound: -size.height,
    upperBound: size.height,
    value: 0.0,
  );

  late final AnimationController _upperPageController = AnimationController(
    vsync: this,
    duration: 2.seconds,
    reverseDuration: 500.milliseconds,
  )..addListener(() {
    if (_upperPageController.status == AnimationStatus.reverse) {
      setState(() {
        isUpperPage = false;
      });
    }
  });

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_upperPageController.isAnimating || _position.isAnimating) return;

    if (!isUpperPage && details.delta.dy > 0) {
      _position.value += details.delta.dy;
    } else if (isUpperPage && details.delta.dy < 0) {
      _position.value += details.delta.dy;
    }

    if (_position.value.abs() > 150) {
      if (isUpperPage && _position.value < -150) {
        _position.value = 0;
        _upperPageController.reverse();
        setState(() {
          isUpperPage = false;
        });
      } else if (!isUpperPage && _position.value > 150) {
        _upperPageController.value = _position.value / size.height;
        _upperPageController.forward();
        setState(() {
          isUpperPage = true;
        });
      }
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    _position.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Container(
              key: ValueKey(_currentPage),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/covers/${_currentPage + 1}_back.png",
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AnimatedOpacity(
                  opacity: isUpperPage ? 0.6 : 0.2,
                  duration: 500.milliseconds,
                  child: Container(color: Colors.black),
                ),
              ),
            ),
          ),
          PageView.builder(
            physics:
                isUpperPage
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
            onPageChanged: _onPageChanged,
            controller: _pageController,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ValueListenableBuilder(
                valueListenable: _scroll,
                builder: (context, scroll, child) {
                  final difference = (scroll - index).abs();
                  final scale = 1 - (difference * 0.15);

                  return AnimatedBuilder(
                    animation: _position,
                    builder: (context, child) {
                      double pageOffset =
                          _pageController.hasClients
                              ? _pageController.page ?? 0
                              : 0;
                      double delta = index - pageOffset;
                      double firstWidgetOffset = delta * 100;
                      double secondWidgetOffset = delta * 10;

                      return GestureDetector(
                        onVerticalDragUpdate: _onVerticalDragUpdate,
                        onVerticalDragEnd: _onVerticalDragEnd,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 300,
                              child: TweenAnimationBuilder(
                                tween: Tween<double>(
                                  begin: secondWidgetOffset,
                                  end: secondWidgetOffset,
                                ),
                                duration: 100.milliseconds,
                                curve: Curves.easeOut,
                                builder: (context, value, child) {
                                  return AnimatedOpacity(
                                    duration: 1.milliseconds,
                                    opacity: max(
                                      min(1, (1 - (value.abs() / 10)).abs()),
                                      0.5,
                                    ),
                                    child: Transform.translate(
                                      offset: Offset(value, 0),
                                      child: child,
                                    ),
                                  );
                                },
                                child: DescribeCard(size: size, index: index)
                                    .animate()
                                    .scale(
                                      begin: Offset(0.85, 0.85),
                                      end: Offset(scale, scale),
                                    )
                                    .moveY(
                                      delay: 100.milliseconds,
                                      end: _position.value * 0.7,
                                    )
                                    .animate(
                                      controller: _upperPageController,
                                      autoPlay: false,
                                    )
                                    .moveY(end: 0)
                                    .slideY(
                                      duration: 500.milliseconds,
                                      begin: 0,
                                      end: 3,
                                    ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              child: TweenAnimationBuilder(
                                tween: Tween<double>(
                                  begin: firstWidgetOffset,
                                  end: firstWidgetOffset,
                                ),
                                duration: 100.milliseconds,
                                curve: Curves.easeOut,
                                builder: (context, value, child) {
                                  return AnimatedOpacity(
                                    duration: 1.milliseconds,
                                    opacity: max(
                                      min(1, (1 - (value.abs() / 100)).abs()),
                                      0.9,
                                    ),
                                    child: Transform.translate(
                                      offset: Offset(value, 0),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: "$index",
                                  child: ImageCard(
                                        size: size.width * 0.7,
                                        index: index,
                                      )
                                      .animate()
                                      .scale(
                                        begin: Offset(0.85, 0.85),
                                        end: Offset(
                                          scale - (1 - scale),
                                          scale - (1 - scale),
                                        ),
                                      )
                                      .moveY(end: _position.value)
                                      .animate(
                                        controller: _upperPageController,
                                        autoPlay: false,
                                      )
                                      .slideY(
                                        duration: 500.milliseconds,
                                        end: 3,
                                      ),
                                ),
                              ),
                            ),

                            difference == 0
                                ? StockDetailsPage(
                                  index: index,
                                  size: size,
                                  upperPageController: _upperPageController,
                                )
                                : Container(),

                            Positioned(
                                  child: Container(
                                        padding: EdgeInsets.only(top: 70),
                                        alignment: Alignment.topCenter,
                                        height: size.height - 50,
                                        width: size.width,
                                        child: Icon(
                                          isUpperPage
                                              ? Icons
                                                  .keyboard_double_arrow_down_rounded
                                              : Icons
                                                  .keyboard_double_arrow_up_rounded,
                                          color: Colors.white.withOpacity(0.5),
                                          size: 30,
                                        ),
                                      )
                                      .animate(
                                        onComplete: (controller) {
                                          controller.value = 0;
                                          controller.forward();
                                        },
                                      )
                                      .slideY(
                                        duration: 1.seconds,
                                        end: isUpperPage ? 0.02 : -0.02,
                                      ),
                                )
                                .animate(
                                  controller: _upperPageController,
                                  autoPlay: false,
                                )
                                .slideY(duration: 500.milliseconds, end: 0.8),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class StockChart extends StatefulWidget {
  final List<(DateTime, double)> priceHistory;
  final bool fullVersion;
  const StockChart({
    super.key,
    required this.priceHistory,
    this.fullVersion = false,
  });

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart>
    with SingleTickerProviderStateMixin {
  late final TransformationController _transformationController =
      TransformationController(Matrix4.diagonal3Values(2, 1, 1))
        ..addListener(() {
          if (!widget.fullVersion) {
            _transformationController.value = Matrix4.diagonal3Values(2, 1, 1);
          }
        });
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );
  late final Animation<Matrix4> _animation = Matrix4Tween(
    begin:
        Matrix4.diagonal3Values(2, 1, 1) * Matrix4.translationValues(0, 0, 0),
    end:
        Matrix4.diagonal3Values(2, 1, 1) *
        Matrix4.translationValues(-160, 0, 0),
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
  );

  late final Animation<Color?> _colorAnimation = ColorTween(
    begin: Colors.red,
    end: Colors.blue,
  ).animate(_animationController);

  @override
  void initState() {
    super.initState();
    _animation.addListener(() {
      _transformationController.value = _animation.value;
    });

    if (widget.fullVersion) {
      Future.delayed(2.5.seconds, () {
        if (mounted) _animationController.forward(from: 0);
      });
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fullVersion = widget.fullVersion;
    final priceHistory = widget.priceHistory;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.4,
          child: Padding(
            padding: EdgeInsets.only(top: 0, right: 18),
            child: AnimatedBuilder(
              animation: _colorAnimation,
              builder:
                  (context, widget) => LineChart(
                    transformationConfig: FlTransformationConfig(
                      scaleAxis: FlScaleAxis.horizontal,
                      minScale: 1.0,
                      maxScale: 25.0,
                      transformationController: _transformationController,
                    ),
                    LineChartData(
                      borderData: FlBorderData(
                        border: Border.all(
                          color:
                              fullVersion
                                  ? Colors.black.withOpacity(0.5)
                                  : Colors.white.withOpacity(0.5),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots:
                              priceHistory.asMap().entries.map((e) {
                                final index = e.key;
                                final item = e.value;
                                final value = item.$2;
                                return FlSpot(index.toDouble(), value);
                              }).toList(),
                          dotData: const FlDotData(show: false),
                          color: _colorAnimation.value,
                          barWidth: 1,
                          shadow: Shadow(
                            color: _colorAnimation.value!,
                            blurRadius: 2,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                _colorAnimation.value!.withValues(alpha: 0.2),
                                _colorAnimation.value!.withValues(alpha: 0.0),
                              ],
                              stops: const [0.5, 1.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],

                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          drawBelowEverything: true,
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            maxIncluded: false,
                            minIncluded: false,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return SideTitleWidget(
                                meta: meta,
                                child: Transform.rotate(
                                  angle: -45 * 3.14 / 180,
                                  child: Text(
                                    '\$ ${value.toInt()}',
                                    style: TextStyle(
                                      color:
                                          fullVersion
                                              ? Colors.black
                                              : Colors.white,
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            maxIncluded: false,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final date = priceHistory[value.toInt()].$1;
                              return SideTitleWidget(
                                meta: meta,
                                child: Transform.rotate(
                                  angle: -45 * 3.14 / 180,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${date.year != 0 ? "${date.year % 100}/" : ""}${date.month}/${date.day}',
                                        style: TextStyle(
                                          color:
                                              fullVersion
                                                  ? Colors.black
                                                  : Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
