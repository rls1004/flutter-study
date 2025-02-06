import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/screens/widgets/photo_list_widget.dart';
import 'package:threads_clone/screens/widgets/replies_image_widget.dart';
import 'package:threads_clone/screens/widgets/text_contents_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/screens/widgets/profile_widget.dart';

class PostCardWidget extends StatefulWidget {
  final int index;
  const PostCardWidget({super.key, required this.index});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  late Map<String, Object> fakeData;
  late int replies;
  late int likes;
  late String time;
  late int numOfPhotos;

  late String author;
  late bool isVerifiedUser;

  late String contents;

  @override
  void initState() {
    super.initState();

    fakeData = generateFakePostData(widget.index);
    replies = fakeData["replies"] as int;
    likes = fakeData["likes"] as int;
    time = fakeData["time"] as String;
    numOfPhotos = fakeData["numOfPhotos"] as int;

    author = fakeData["author"] as String;
    isVerifiedUser = fakeData["isVerifiedUser"] as bool;

    contents = fakeData["contents"] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.index > 0)
          Divider(
            color: Colors.black.withOpacity(0.1),
            thickness: 0.7,
          ),
        IntrinsicHeight(
          child: Stack(
            children: [
              Positioned(
                child: Row(
                  children: [
                    Column(
                      children: [
                        ProfileWidget(
                          profileUrl: getUrl(width: 60),
                          withPlusButton: true,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: VerticalDivider(
                              color: Colors.black.withOpacity(0.1),
                              thickness: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Gaps.h60,
                            TextContentsWidget(
                                author: author,
                                isVerifiedUser: isVerifiedUser,
                                time: time,
                                contents: contents)
                          ],
                        ),
                        if (numOfPhotos > 0)
                          PhotoListWidget(numOfPhotos: numOfPhotos),
                        Gaps.v10,
                        ReactionButtons()
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        ReactionInfos(replies: replies, likes: likes),
      ],
    );
  }
}

class ReactionButtons extends StatelessWidget {
  const ReactionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Gaps.h64,
          FaIcon(
            FontAwesomeIcons.heart,
            size: Sizes.size24,
          ),
          Gaps.h10,
          FaIcon(
            FontAwesomeIcons.comment,
            size: Sizes.size24,
          ),
          Gaps.h10,
          FaIcon(
            FontAwesomeIcons.retweet,
            size: Sizes.size24,
          ),
          Gaps.h10,
          FaIcon(
            FontAwesomeIcons.paperPlane,
            size: Sizes.size24,
          ),
        ],
      );
}

class ReactionInfos extends StatelessWidget {
  const ReactionInfos({
    super.key,
    required this.replies,
    required this.likes,
  });

  final int replies;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RepliesImageWidget(num: replies),
        Gaps.h5,
        Text(
          "$replies replies ・ $likes likes",
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
