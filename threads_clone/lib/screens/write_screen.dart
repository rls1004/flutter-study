import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/screens/widgets/fake_generator.dart';
import 'package:threads_clone/screens/widgets/profile_widget.dart';

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

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  void _onChange(String value) {
    setState(() {
      _contents = value;
    });
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
              child: GestureDetector(
                onTap: () => textFocus.unfocus(),
                child: Scaffold(
                  appBar: WriteScreenAppBar(),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              ProfileWidget(
                                profileUrl:
                                    getUrl(width: 40, seed: widget.userName),
                                withPlusButton: false,
                              ),
                              Expanded(
                                child: VerticalDivider(
                                  thickness: 1.5,
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ),
                              ProfileWidget(
                                profileUrl:
                                    getUrl(width: 40, seed: widget.userName),
                                withPlusButton: false,
                                radius: 10,
                              ),
                            ],
                          ),
                          Expanded(
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
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
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
                                FaIcon(
                                  FontAwesomeIcons.paperclip,
                                  size: 20,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                Gaps.v52,
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  bottomSheet: Container(
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
                                color: Colors.blueAccent.withOpacity(
                                    _contents.isNotEmpty ? 1 : 0.3),
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  resizeToAvoidBottomInset: true,
                ),
              ),
            ),
          ),
        ),
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
