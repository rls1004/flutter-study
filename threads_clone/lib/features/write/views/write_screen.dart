import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/features/auth/repos/authentication_repo.dart';
import 'package:threads_clone/features/profiles/view_models/users_view_model.dart';
import 'package:threads_clone/features/write/view_models/upload_post_view_model.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/features/write/views/camera/camera_screen.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/features/home/views/widgets/profile_widget.dart';
import 'package:threads_clone/utils/utils.dart';
import 'package:video_player/video_player.dart';

bool isIMG(XFile file) =>
    file.name.endsWith(".jpg") || file.name.endsWith(".png");
bool isMP4(XFile file) => file.name.endsWith(".mp4");

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  TextEditingController ctrl = TextEditingController();

  FocusNode textFocus = FocusNode();

  String _contents = "";
  String _filePath = "";
  bool isRecorded = false;
  bool isVideoReady = false;
  bool isImageReady = false;

  late VideoPlayerController _videoPlayerController;

  void onAttachmentTap() async {
    isRecorded = false;
    isVideoReady = false;
    isImageReady = false;
    setState(() {});

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraScreen(),
      ),
    );

    if (result != null) {
      isRecorded = true;
      _filePath = result.path;
      if (isMP4(result)) {
        _videoPlayerController = VideoPlayerController.file(File(_filePath));
        await _videoPlayerController.initialize();
        await _videoPlayerController.setLooping(true);
        await _videoPlayerController.play();
        isVideoReady = true;
      } else if (isIMG(result)) {
        isImageReady = true;
      }
    }

    setState(() {});
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

  void _onTapPost() async {
    ref.read(uploadPostProvider.notifier).uploadPost(context,
        description: _contents,
        image: _filePath.isNotEmpty ? File(_filePath) : null);
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
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
          data: (data) => ref.watch(uploadPostProvider).when(
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
                data: (data) => Stack(
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
                            color: Colors.white
                                .withOpacity(isDarkMode(context) ? 0.3 : 0.7),
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
                            bottomSheet: WriteScreenBottomBar(
                              contents: _contents,
                              onTapPost: _onTapPost,
                            ),
                            resizeToAvoidBottomInset: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        );
  }

  Widget writeRightSide(BuildContext context) {
    final String userName = ref.read(authRepo).user!.email!.split('@')[0];

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v5,
          Text(
            textAlign: TextAlign.left,
            userName,
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
                color: Colors.grey,
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
    final String userName = ref.read(authRepo).user!.email!.split('@')[0];

    return Column(
      children: [
        ProfileWidget(
          profileUrl: getUrl(width: 40, seed: userName),
          withPlusButton: false,
        ),
        Expanded(
          child: Opacity(
            opacity: 0.5,
            child: VerticalDivider(
              thickness: 1.5,
            ),
          ),
        ),
        ProfileWidget(
          profileUrl: getUrl(width: 40, seed: userName),
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
        child: Opacity(
          opacity: 0.4,
          child: FaIcon(
            FontAwesomeIcons.paperclip,
            size: 20,
          ),
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
                          ? Image.file(File(_filePath))
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
      title: Text(
        "New thread",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      leadingWidth: 80,
      leading: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Divider(height: 0, thickness: 0.3, color: Colors.grey),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class WriteScreenBottomBar extends ConsumerWidget {
  final String contents;
  final Function onTapPost;

  const WriteScreenBottomBar({
    super.key,
    required this.contents,
    required this.onTapPost,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0.4,
              child: Text(
                "Anyone can reply",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () => onTapPost(),
              child: Text(
                "Post",
                style: TextStyle(
                  color: Colors.blueAccent
                      .withOpacity(contents.isNotEmpty ? 1 : 0.3),
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
