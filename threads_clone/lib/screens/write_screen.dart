import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/screens/camera_screen.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/screens/widgets/profile_widget.dart';
import 'package:video_player/video_player.dart';

class WriteScreen extends StatefulWidget {
  final String userName;
  const WriteScreen({super.key, required this.userName});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController ctrl = TextEditingController();

  FocusNode textFocus = FocusNode();

  String _contents = "";
  late XFile resultFile;
  bool isRecorded = false;
  bool isVideoReady = false;
  bool isImageReady = false;

  late VideoPlayerController _videoPlayerController;

  bool isIMG(XFile file) =>
      file.name.endsWith(".jpg") || file.name.endsWith(".png");
  bool isMP4(XFile file) => file.name.endsWith(".mp4");

  void onAttachmentTap() async {
    isRecorded = false;
    isVideoReady = false;
    isImageReady = false;
    setState(() {});

    void getFile(XFile recordedFile) {
      resultFile = recordedFile;
      isRecorded = true;
      setState(() {});
    }

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => CameraScreen(getFile: getFile),
      ),
    )
        .whenComplete(() async {
      if (isRecorded && isMP4(resultFile)) {
        _videoPlayerController =
            VideoPlayerController.file(File(resultFile.path));
        await _videoPlayerController.initialize();
        await _videoPlayerController.setLooping(true);
        await _videoPlayerController.play();
        isVideoReady = true;
        setState(() {});
      } else if (isRecorded && isIMG(resultFile)) {
        isImageReady = true;
        setState(() {});
      }
    });
  }

  void _onChange(String value) {
    setState(() {
      _contents = value;
    });
  }

  void _onTapCancel() {
    if (isVideoReady) _videoPlayerController.dispose();

    isRecorded = false;
    isVideoReady = false;
    isImageReady = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void dispose() {
    if (isVideoReady) _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Positioned.fill(
          top: 45,
          left: 15,
          right: 15,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.93,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                // onTap: () => textFocus.unfocus(),
                child: Scaffold(
                  appBar: WriteScreenAppBar(),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                writeLeftSide(),
                                writeRightSide(context)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottomSheet: WriteScreenBottomBar(contents: _contents),
                  resizeToAvoidBottomInset: true,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget writeRightSide(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v5,
          Text(
            textAlign: TextAlign.left,
            widget.userName,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              fontSize: Sizes.size14,
            ),
          ),
          TextField(
            onChanged: _onChange,
            controller: ctrl,
            focusNode: textFocus,
            autofocus: true,
            cursorColor: Colors.blueAccent,
            cursorHeight: 20,
            cursorWidth: 2,
            maxLines: null,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              hintText: "Start a thread...",
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.4),
                letterSpacing: -0.5,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Gaps.v10,
          isRecorded ? displayFile(context) : displayAttachButton(),
        ],
      ),
    );
  }

  Widget writeLeftSide() {
    return Column(
      children: [
        ProfileWidget(
          profileUrl: getUrl(width: 40, seed: widget.userName),
          withPlusButton: false,
        ),
        Expanded(
          child: VerticalDivider(
            thickness: 1.5,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        ProfileWidget(
          profileUrl: getUrl(width: 40, seed: widget.userName),
          withPlusButton: false,
          radius: 10,
        ),
      ],
    );
  }

  Widget displayAttachButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
      child: GestureDetector(
        onTap: onAttachmentTap,
        child: FaIcon(
          FontAwesomeIcons.paperclip,
          size: 20,
          color: Colors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget displayFile(BuildContext context) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRect(
            child: Align(
              widthFactor: 1,
              heightFactor: 0.35,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  child: isVideoReady
                      ? VideoPlayer(_videoPlayerController)
                      : isImageReady
                          ? Image.file(File(resultFile.path))
                          : null,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: _onTapCancel,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.cancel,
                size: Sizes.size28,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class WriteScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WriteScreenAppBar({
    super.key,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      elevation: 0.2,
      title: Text(
        "New thread",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      leadingWidth: 80,
      leading: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WriteScreenBottomBar extends StatelessWidget {
  const WriteScreenBottomBar({
    super.key,
    required String contents,
  }) : _contents = contents;

  final String _contents;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Anyone can reply",
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Post",
                style: TextStyle(
                  color: Colors.blueAccent
                      .withOpacity(_contents.isNotEmpty ? 1 : 0.3),
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
