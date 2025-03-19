import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MusicPalyerDetailScreen extends StatefulWidget {
  final int index;
  const MusicPalyerDetailScreen({super.key, required this.index});

  @override
  State<MusicPalyerDetailScreen> createState() =>
      _MusicPalyerDetailScreenState();
}

class _MusicPalyerDetailScreenState extends State<MusicPalyerDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _progressController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 60),
  )..forward();

  late final AnimationController _marqueeController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 20),
  )..repeat(reverse: true);

  late final AnimationController _playPaushController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  late final Animation<Offset> _marqueeTween = Tween(
    begin: Offset(0.1, 0),
    end: Offset(-0.6, 0),
  ).animate(_marqueeController);

  @override
  void dispose() {
    _progressController.dispose();
    _marqueeController.dispose();
    super.dispose();
  }

  void _onPlayPauseTap() {
    if (_playPaushController.isCompleted) {
      _playPaushController.reverse();
    } else {
      _playPaushController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("BATMAN NINJA")),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: "${widget.index}",
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 8),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/covers/${widget.index}.webp"),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          AnimatedBuilder(
            animation: _progressController,

            builder: (context, child) {
              return Column(
                children: [
                  CustomPaint(
                    size: Size(size.width - 80, 5),
                    painter: ProgressBar(
                      progressValue: _progressController.value,
                    ),
                  ),

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Text(
                          "${(60 * _progressController.value ~/ 60)}:${(60 * _progressController.value % 60) ~/ 1}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${((60 - 60 * _progressController.value) ~/ 60)}:${((60 - 60 * _progressController.value) % 60) ~/ 1}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Batman ninja",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  SlideTransition(
                    position: _marqueeTween,
                    child: Text(
                      "A Film By Junpei Mizusaki, Shinji Takagi - 2025",
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      softWrap: false,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: _onPlayPauseTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedIcon(
                          icon: AnimatedIcons.pause_play,
                          progress: _playPaushController,
                          size: 60,
                        ),
                        // LottieBuilder.asset(
                        //   "assets/animations/play-lottie.json",
                        //   controller: _playPaushController,
                        //   onLoaded: (composition) {
                        //     _playPaushController.duration =
                        //         composition.duration;
                        //   },
                        //   width: 200,
                        //   height: 200,
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;
  ProgressBar({required this.progressValue});

  @override
  void paint(Canvas canvas, Size size) {
    final progress = progressValue * size.width;
    final backgroundBarPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.fill;
    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(10),
    );
    canvas.drawRRect(trackRRect, backgroundBarPaint);

    final progressBarPaint =
        Paint()
          ..color = Colors.grey.shade500
          ..style = PaintingStyle.fill;
    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      Radius.circular(10),
    );
    canvas.drawRRect(progressRRect, progressBarPaint);

    final thumbPaint =
        Paint()
          ..color = Colors.grey.shade500
          ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(progress, size.height / 2), 10, thumbPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}
