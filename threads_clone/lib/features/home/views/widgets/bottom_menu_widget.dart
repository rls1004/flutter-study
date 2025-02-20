import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';

class BottomMenuWidget extends StatefulWidget {
  const BottomMenuWidget({super.key});

  @override
  State<BottomMenuWidget> createState() => _BottomMenuWidgetState();
}

class _BottomMenuWidgetState extends State<BottomMenuWidget> {
  int _selectedMenu = 0;

  void _onReportTap() {
    setState(() {
      _selectedMenu = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 340;
    List<String> reportReasons = [
      "I just don't like it",
      "It's unlawful content under NetzDG",
      "It's spam",
      "Hate speech or symbols",
      "Nudity or sexual activity",
      "Hmm",
      "Hmmmmm...",
      "others",
    ];

    return Container(
      constraints: BoxConstraints(
        maxHeight: 400,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size20,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(13),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
          if (_selectedMenu == 0)
            Column(
              children: [
                Container(
                  width: buttonWidth,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 17),
                    child: Text(
                      "Unfollow",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  width: buttonWidth,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 17),
                    child: Text(
                      "Mute",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Gaps.v20,
                Container(
                  width: buttonWidth,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 17),
                    child: Text(
                      "Hide",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _onReportTap,
                  child: Container(
                    width: buttonWidth,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.12),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 17),
                      child: Text(
                        "Report",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size16,
                          color: Colors.red,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (_selectedMenu == 4) ...[
            Text(
              "Report",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: Sizes.size16,
                letterSpacing: -0.5,
              ),
            ),
            Gaps.v10,
            Divider(
              color: Colors.grey.withOpacity(0.3),
              thickness: 0.7,
              height: 0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size20,
                            vertical: Sizes.size10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Why are you reporting this thread?",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Sizes.size16,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Gaps.v6,
                              Opacity(
                                opacity: 0.5,
                                child: Text(
                                  "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                                  style: TextStyle(
                                    fontSize: Sizes.size14,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        for (var reason in reportReasons) ...[
                          Divider(
                            thickness: 0.5,
                            height: 0,
                          ),
                          ListTile(
                            title: Text(
                              reason,
                              style: TextStyle(
                                fontSize: Sizes.size14,
                              ),
                            ),
                            trailing: Opacity(
                              opacity: 0.5,
                              child: FaIcon(
                                FontAwesomeIcons.chevronRight,
                                size: Sizes.size14,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          Gaps.v32,
        ],
      ),
    );
  }
}
