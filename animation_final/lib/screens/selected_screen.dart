import 'package:animation_final/consts/data.dart';
import 'package:animation_final/screens/home_screen.dart';
import 'package:animation_final/screens/widgets/card_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class SelectedScreen extends StatefulWidget {
  final int index;
  const SelectedScreen({super.key, required this.index});

  @override
  State<SelectedScreen> createState() => _SelectedScreenState();
}

class _SelectedScreenState extends State<SelectedScreen>
    with SingleTickerProviderStateMixin {
  late final _animateController = AnimationController(vsync: this);

  @override
  void dispose() {
    _animateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 30,
          children: [
            Row(
              spacing: 20,
              children: [
                Hero(
                  tag: "${widget.index}",
                  child: ImageCard(
                    size: size.width * 0.28,
                    index: widget.index,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      addSubjectMarker(stocksTicker[widget.index]),
                      style: TextStyle(fontSize: 20),
                    ),
                    Stack(
                      children: [
                        Text("기뻐하고 있어요!", style: TextStyle(fontSize: 20))
                            .animate()
                            .fadeIn(
                              delay: 500.milliseconds,
                              duration: 500.milliseconds,
                            )
                            .fadeOut(
                              delay: 3.5.seconds,
                              duration: 500.milliseconds,
                            ),
                        Row(
                          children: [
                            Text(
                              "반려 주식",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text("이 되었어요!", style: TextStyle(fontSize: 20)),
                          ],
                        ).animate().fadeIn(
                          delay: 4.seconds,
                          duration: 500.milliseconds,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            StockChart(
              priceHistory: pricesOfStock[widget.index],
              fullVersion: true,
            ).animate().fadeIn(delay: 1.2.seconds, duration: 500.milliseconds),

            Stack(
              children: [
                Text("꾸준히 물 타주는 것 잊지마세요 ☺️", style: TextStyle(fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 2),
                  child: FaIcon(
                    FontAwesomeIcons.slash,
                    size: 18,
                    color: Colors.red,
                  ),
                ).animate().scaleY(
                  begin: 0,
                  end: 1,
                  delay: 6.seconds,
                  duration: 500.milliseconds,
                  curve: Curves.easeIn,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 78, top: 8),
                  child: FaIcon(
                    FontAwesomeIcons.slash,
                    size: 18,
                    color: Colors.red,
                  ),
                ).animate().scaleY(
                  begin: 0,
                  end: 1,
                  delay: 6.seconds,
                  duration: 500.milliseconds,
                  curve: Curves.easeIn,
                ),
              ],
            ).animate().fadeIn(delay: 5.seconds, duration: 500.milliseconds),

            Container(
                  child: Lottie.asset(
                    "assets/animations/plant-lottie.json",
                    onLoaded: (p0) {
                      _animateController.duration = p0.duration;
                    },
                    controller: _animateController,
                  ),
                )
                .animate(
                  onComplete: (controller) {
                    _animateController.repeat(reverse: true);
                  },
                )
                .fadeIn(delay: 6.seconds, duration: 500.milliseconds),
          ],
        ),
      ),
    );
  }
}

String addSubjectMarker(String name) {
  final lastChar = name.toLowerCase().characters.last;

  const vowels = {'a', 'e', 'i', 'o', 'u'};
  if (vowels.contains(lastChar)) {
    return "$name가";
  } else {
    return "$name이";
  }
}
