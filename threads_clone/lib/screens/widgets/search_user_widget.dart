import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/screens/widgets/profile_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';

class SearchUserWidget extends StatefulWidget {
  final Map<String, String> userInfo;
  const SearchUserWidget({super.key, required this.userInfo});

  @override
  State<SearchUserWidget> createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  @override
  Widget build(BuildContext context) {
    String userName = widget.userInfo["userName"]!;
    String realName = widget.userInfo["realName"]!;
    String followers = widget.userInfo["followers"]!;
    String profileUrl = getUrl(width: 50, seed: userName);

    return ListTile(
      minVerticalPadding: 0,
      minTileHeight: 0,
      title: Column(
        spacing: 0,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileWidget(profileUrl: profileUrl),
              Expanded(
                child: Column(
                  spacing: 0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v5,
                    Row(
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5,
                            height: 1,
                          ),
                        ),
                        Gaps.h5,
                        SvgPicture.asset(
                          'assets/icons/badge-check.svg',
                          width: 12,
                          height: 12,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    Text(
                      realName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.5,
                          height: 1.5),
                    ),
                    Gaps.v5,
                    Text(
                      "$followers followers",
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.5,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Follow",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
            thickness: 0.7,
            indent: 50,
            height: 10,
          ),
        ],
      ),
    );
  }
}
