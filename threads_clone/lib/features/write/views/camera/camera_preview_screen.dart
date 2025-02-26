import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:video_player/video_player.dart';

bool isIMG(XFile file) =>
    file.name.endsWith(".jpg") || file.name.endsWith(".png");
bool isMP4(XFile file) => file.name.endsWith(".mp4");

class CameraPreviewScreen extends StatefulWidget {
  final XFile file;

  const CameraPreviewScreen({
    super.key,
    required this.file,
  });

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  String? _croppedFilePath;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.file.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [WebUiSettings(context: context)],
    );
    if (croppedFile != null) {
      _croppedFilePath = croppedFile.path;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (isMP4(widget.file)) _initVideo();
    if (isIMG(widget.file)) cropImage(widget.file.path);
  }

  @override
  void dispose() {
    if (isMP4(widget.file)) _videoPlayerController.dispose();
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
                    child: isMP4(widget.file)
                        ? _videoPlayerController.value.isInitialized
                            ? VideoPlayer(_videoPlayerController)
                            : null
                        : isIMG(widget.file)
                            ? Image.file(
                                File(_croppedFilePath == null
                                    ? widget.file.path
                                    : _croppedFilePath!),
                              )
                            : Container(),
                  ),
                ),
              ),
            ),
          ),
          PreviewBottomBar(
              file: XFile(_croppedFilePath == null
                  ? widget.file.path
                  : _croppedFilePath!)),
        ],
      ),
    );
  }
}

class PreviewBottomBar extends StatelessWidget {
  const PreviewBottomBar({
    super.key,
    required this.file,
  });

  final XFile file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size28, vertical: Sizes.size20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              "다시 찍기",
              style: TextStyle(
                fontSize: Sizes.size20,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(file),
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
