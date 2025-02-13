import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/screens/camera/camera_preview_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _isInitialized = false;
  bool _isSelfieMode = false;
  int _currentFlashMode = 0;

  final List<FlashMode> _flashModes = [
    FlashMode.auto,
    FlashMode.always,
    FlashMode.off,
    FlashMode.torch,
  ];
  final List<Icon> _flashModeIcons = [
    Icon(Icons.flash_auto),
    Icon(Icons.flash_on),
    Icon(Icons.flash_off),
    Icon(Icons.flashlight_on_outlined)
  ];

  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();

    _isInitialized = true;
    _currentFlashMode = _flashModes.indexOf(_cameraController.value.flashMode);
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode() async {
    _currentFlashMode += 1;
    _currentFlashMode %= _flashModes.length;
    await _cameraController.setFlashMode(_flashModes[_currentFlashMode]);
    _currentFlashMode = _flashModes.indexOf(_flashModes[_currentFlashMode]);
    setState(() {});
  }

  Future<void> _takePicture() async {
    if (_cameraController.value.isRecordingVideo) return;

    XFile file = await _cameraController.takePicture();

    if (!mounted) return;
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CameraPreviewScreen(
              file: file,
            )));

    if (result != null) {
      if (!mounted) return;
      Navigator.of(context).pop(result);
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final XFile file = await _cameraController.stopVideoRecording();

    if (!mounted) return;
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CameraPreviewScreen(
                file: file,
              )),
    );

    if (result != null) {
      if (!mounted) return;
      Navigator.of(context).pop(result);
    }
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _onPickMediaPressed() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    if (!mounted) return;
    Navigator.of(context).pop(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: !_hasPermission || !_isInitialized
            ? RequestWidget()
            : Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CameraPreview(_cameraController),
                        Positioned(
                          bottom: Sizes.size40,
                          left: Sizes.size40,
                          right: Sizes.size40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                color: Colors.white,
                                onPressed: () => _setFlashMode(),
                                icon: _flashModeIcons[_currentFlashMode],
                              ),
                              IconButton(
                                color: Colors.white,
                                onPressed: _toggleSelfieMode,
                                icon: Icon(Icons.cameraswitch),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: Sizes.size28,
                          child: GestureDetector(
                            onTap: _takePicture,
                            onLongPress: _startRecording,
                            onLongPressUp: () async {
                              await _stopRecording();
                            },
                            child: ScaleTransition(
                              scale: _buttonAnimation,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: Sizes.size64,
                                    height: Sizes.size64,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Sizes.size64 + Sizes.size11,
                                    height: Sizes.size64 + Sizes.size11,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: Sizes.size3,
                                      value: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Sizes.size64 + Sizes.size11,
                                    height: Sizes.size64 + Sizes.size11,
                                    child: CircularProgressIndicator(
                                      color: Colors.red.shade400,
                                      strokeWidth: Sizes.size6,
                                      value: _progressAnimationController.value,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v40,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Gaps.h64,
                      Text(
                        "Camera",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: _onPickMediaPressed,
                        child: Text(
                          "Library",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

class RequestWidget extends StatelessWidget {
  const RequestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Requesting permissions...",
            style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.size20,
            ),
          ),
          Gaps.v20,
          CircularProgressIndicator.adaptive(
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
