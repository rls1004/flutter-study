import 'dart:async';

import 'package:flutter/material.dart';

class HomePomo extends StatefulWidget {
  const HomePomo({super.key});

  @override
  State<HomePomo> createState() => _HomePomoState();
}

class _HomePomoState extends State<HomePomo> {
  static const int breakTime = 5; // * 60;
  int selectedMin = 15;
  int totlaSeconds = 15 * 60;
  int totalPomodoros = 0;
  int totalGoal = 0;
  bool isRunning = false;
  bool isBreak = false;

  late Timer? timer;

  void onPressButtons(int min) {
    setState(() {
      selectedMin = min;
      if (!isRunning) {
        totlaSeconds = selectedMin * 60;
        if (selectedMin == 10) totlaSeconds = 10;
      }
    });
  }

  void onTick(Timer timer) {
    if (totlaSeconds == 0 && !isBreak) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        if (totalPomodoros == 4) {
          totalPomodoros = 0;
          totalGoal = totalGoal + 1;
        }
        isRunning = false;
        isBreak = true;
        totlaSeconds = breakTime;
      });
      timer.cancel();
    } else if (totlaSeconds == 0 && isBreak) {
      setState(() {
        isBreak = false;
        isRunning = false;
        totlaSeconds = selectedMin * 60;
        timer.cancel();

        if (selectedMin == 10) totlaSeconds = 10;
      });
    } else {
      setState(() {
        totlaSeconds = totlaSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer!.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onStopPressed() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      totlaSeconds = isBreak ? breakTime : selectedMin * 60;
      if (totlaSeconds == 600) totlaSeconds = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('POMOTIMER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 120,
                            height: 170,
                          ),
                        ),
                        Positioned(
                          top: 6,
                          left: -5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 130,
                            height: 170,
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: -10,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 140,
                            height: 170,
                            child: Text('${totlaSeconds ~/ 60}',
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                      alignment: Alignment.topCenter,
                      child: Text(':',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w700,
                            color: Colors.red.shade200,
                          ))),
                ),
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 120,
                            height: 170,
                          ),
                        ),
                        Positioned(
                          top: 6,
                          left: -5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 130,
                            height: 170,
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: -10,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: 140,
                            height: 170,
                            child: Text('${totlaSeconds % 60}',
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.2, 0.8, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var min in [10, 15, 20, 25, 30, 35])
                        Container(
                          width: 65,
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: min == selectedMin
                                  ? Theme.of(context).cardColor
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!, //Colors.red.shade200,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: min == selectedMin
                                ? Theme.of(context).cardColor
                                : null,
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(1)),
                            ),
                            onPressed: () {
                              onPressButtons(min);
                            },
                            child: Text(
                              min == 10 ? '${min}s' : '$min',
                              style: TextStyle(
                                fontSize: 25,
                                color: min == selectedMin
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              heightFactor: 1.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: 17,
                        left: 17,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                          color: const Color.fromARGB(255, 122, 39, 33),
                          onPressed: onStopPressed,
                          icon: const Icon(Icons.stop_circle, size: 100),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 17,
                        left: 17,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        child: IconButton(
                          color: const Color.fromARGB(255, 122, 39, 33),
                          onPressed:
                              isRunning ? onPausePressed : onStartPressed,
                          icon: Icon(
                              isRunning
                                  ? Icons.pause_circle_filled_outlined
                                  : Icons.play_circle_fill_outlined,
                              size: 100),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    '$totalPomodoros/4',
                    style: TextStyle(
                      fontSize: 28,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    '$totalGoal/12',
                    style: TextStyle(
                      fontSize: 28,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'ROUND',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'GOAL',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
