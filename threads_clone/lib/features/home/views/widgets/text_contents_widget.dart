import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/features/home/views/widgets/bottom_menu_widget.dart';

class TextContentsWidget extends StatelessWidget {
  final String author;
  final bool isVerifiedUser;
  final String time;
  final String contents;
  const TextContentsWidget(
      {super.key,
      required this.author,
      required this.isVerifiedUser,
      required this.time,
      required this.contents});

  void _onMenusTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomMenuWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v6,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    author,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.h4,
                  if (isVerifiedUser)
                    SvgPicture.asset(
                      'assets/icons/badge-check.svg',
                      width: 12,
                      height: 12,
                      color: Colors.blue,
                    ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Opacity(
                    opacity: 0.4,
                    child: Text(
                      time,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Gaps.h10,
                  GestureDetector(
                    onTap: () => _onMenusTap(context),
                    child: Text(
                      "•••",
                      style: TextStyle(
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            contents,
          ),
        ],
      ),
    );
  }
}
