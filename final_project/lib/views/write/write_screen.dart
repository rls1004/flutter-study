import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/users_view_model.dart';
import 'package:final_project/view_models/write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController _controller = TextEditingController();

  int _recordTime = DateTime.now().hour;
  String _contents = "";
  int _selectedEmoji = -1;

  final List<String> _emojiList = ["😆", "☺️", "😶‍🌫️", "😢", "😡"];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _contents = _controller.text;
      setState(() {});
    });
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
  }

  void _onTapEmotion(v) {
    _selectedEmoji = v;
    setState(() {});
  }

  void _onTapCancel() {
    _contents = "";
    _controller.text = "";
    _selectedEmoji = -1;
    setState(() {});
  }

  void _onTapEditTime(int v) {
    _recordTime = _recordTime + v;
    _recordTime = _recordTime % 24;
    setState(() {});
  }

  bool _isReady() {
    return _contents.isNotEmpty && _selectedEmoji != -1;
  }

  void _onTapSave() {
    if (!_isReady()) return;
    ref
        .read(writeCardProvider.notifier)
        .uploadCard(
          context,
          contents: _contents,
          emoji: _selectedEmoji,
          recordTime: _recordTime,
        );
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(usersProvider)
        .when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading:
              () =>
                  Center(child: CircularProgressIndicator(color: Colors.blue)),
          data:
              (data) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: GestureDetector(
                    onTap: _onTapScaffold,
                    child: Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size20,
                          horizontal: Sizes.size20,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.transparent,
                                          size: Sizes.size20,
                                        ),
                                        style: ButtonStyle(
                                          overlayColor: WidgetStatePropertyAll(
                                            Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "오늘의 감정",
                                        style: TextStyle(
                                          fontSize: Sizes.size20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: _onTapCancel,
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.grey,
                                          size: Sizes.size28,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        style: ButtonStyle(
                                          padding: WidgetStatePropertyAll(
                                            EdgeInsets.zero,
                                          ),
                                        ),
                                        onPressed: () => _onTapEditTime(-1),
                                        icon: Icon(
                                          Icons.arrow_left_rounded,
                                          size: Sizes.size28,
                                        ),
                                      ),

                                      SizedBox(
                                        width: Sizes.size36,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "$_recordTime시",
                                          style: TextStyle(
                                            fontSize: Sizes.size16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),

                                      IconButton(
                                        style: ButtonStyle(
                                          padding: WidgetStatePropertyAll(
                                            EdgeInsets.zero,
                                          ),
                                        ),
                                        onPressed: () => _onTapEditTime(1),
                                        icon: Icon(
                                          Icons.arrow_right_rounded,
                                          size: Sizes.size28,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var (index, emoji)
                                          in _emojiList.indexed)
                                        TextButton(
                                          onPressed: () => _onTapEmotion(index),
                                          style: ButtonStyle(
                                            padding: WidgetStatePropertyAll(
                                              EdgeInsets.zero,
                                            ),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                  _selectedEmoji == index
                                                      ? Colors.blue.withOpacity(
                                                        0.3,
                                                      )
                                                      : Colors.transparent,
                                                ),
                                          ),
                                          child: Text(
                                            emoji,
                                            style: TextStyle(
                                              fontSize: Sizes.size28,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),

                                  Gaps.v10,

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size10,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _controller,
                                      maxLines: 4,
                                      maxLength: 80,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: Sizes.size10,
                                          vertical: Sizes.size10,
                                        ),
                                        hintText: "오늘의 기분은..",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Container()),

                                  Center(
                                    child: ElevatedButton(
                                      onPressed: _onTapSave,
                                      style: ButtonStyle(
                                        shape:
                                            WidgetStateOutlinedBorder.fromMap({
                                              WidgetState
                                                  .any: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            }),
                                        padding: WidgetStateProperty.all(
                                          EdgeInsets.zero,
                                        ),
                                        backgroundColor:
                                            WidgetStateColor.resolveWith(
                                              (state) =>
                                                  _isReady()
                                                      ? Colors.blue.shade400
                                                      : Colors.blue.shade200,
                                            ),
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            1,
                                        height: Sizes.size48,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "등록",
                                              style: GoogleFonts.orbit(
                                                textStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(
                                                        _isReady() ? 1 : 0.6,
                                                      ),
                                                  fontSize: Sizes.size20,
                                                  fontWeight: FontWeight.w600,
                                                ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        );
  }
}
