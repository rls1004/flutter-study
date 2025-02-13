import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';

class CameraPreviewScreen extends StatefulWidget {
  final XFile file;
  final Function setConfirm;
  final bool isCapture;
  final bool isVideo;

  const CameraPreviewScreen(
      {super.key,
      required this.file,
      this.isCapture = false,
      this.isVideo = false,
      required this.setConfirm});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  Future<void> _initVideo() async {
    if (widget.isVideo) {
      _videoPlayerController =
          VideoPlayerController.file(File(widget.file.path));
      await _videoPlayerController.initialize();
      await _videoPlayerController.setLooping(true);
      await _videoPlayerController.play();
    } else if (widget.isCapture) {}

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    if (widget.isVideo) _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRect(
              child: Align(
                widthFactor: 1,
                heightFactor: 0.4,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: widget.isVideo
                        ? _videoPlayerController.value.isInitialized
                            ? VideoPlayer(_videoPlayerController)
                            : null
                        : widget.isCapture
                            ? Image.file(File(widget.file.path))
                            : Container(),
                  ),
                ),
              ),
            ),
          ),
          PreviewBottomBar(widget: widget),
        ],
      ),
    );
  }
}

class PreviewBottomBar extends StatelessWidget {
  const PreviewBottomBar({
    super.key,
    required this.widget,
  });

  final CameraPreviewScreen widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size28, vertical: Sizes.size20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              "다시 찍기",
              style: TextStyle(
                fontSize: Sizes.size20,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.setConfirm(true);
              Navigator.pop(context);
            },
            child: Text(
              "사용 하기",
              style: TextStyle(
                fontSize: Sizes.size20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
