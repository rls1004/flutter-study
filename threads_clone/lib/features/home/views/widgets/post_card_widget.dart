import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/features/home/models/post_data_model.dart';
import 'package:threads_clone/features/profiles/models/reply_data_model.dart';
import 'package:threads_clone/features/home/views/widgets/photo_list_widget.dart';
import 'package:threads_clone/features/home/views/widgets/replies_image_widget.dart';
import 'package:threads_clone/features/home/views/widgets/text_contents_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/features/home/views/widgets/profile_widget.dart';

class PostCardWidget extends StatefulWidget {
  final String userName;
  final PostDataModel postData;
  final ReplyDataModel? replyData;

  const PostCardWidget(
      {super.key, this.userName = "", required this.postData, this.replyData});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  late int replies;
  late int likes;
  late int time;
  late String timeFormat;
  late int numOfPhotos;

  late String author;
  late bool isVerifiedUser;

  late String contents;

  @override
  void initState() {
    super.initState();
    replies = widget.postData.replies;
    likes = widget.postData.likes;
    time = widget.postData.time;
    timeFormat = widget.postData.getTimeFormat();
    numOfPhotos = widget.postData.numOfPhotos;

    author = widget.postData.author;
    isVerifiedUser = widget.postData.isVerifiedUser;

    contents = widget.postData.contents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Stack(
            children: [
              Positioned(
                child: Row(
                  children: [
                    Column(
                      children: [
                        ProfileWidget(
                          profileUrl: getUrl(width: 60, seed: author),
                          withPlusButton: true,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Opacity(
                              opacity: 0.5,
                              child: VerticalDivider(
                                thickness: 1.5,
                              ),
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
                                time: timeFormat,
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
        ReactionInfos(replies: replies, likes: likes, reply: widget.replyData),
        Divider(
          thickness: 0.4,
        ),
      ],
    );
  }
}

class ReactionButtons extends StatelessWidget {
  final bool reply;
  const ReactionButtons({
    super.key,
    this.reply = false,
  });

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: 0.8,
        child: Row(
          children: [
            if (!reply) Gaps.h64,
            FaIcon(
              FontAwesomeIcons.heart,
              size: Sizes.size20,
            ),
            Gaps.h10,
            FaIcon(
              FontAwesomeIcons.comment,
              size: Sizes.size20,
            ),
            Gaps.h10,
            FaIcon(
              FontAwesomeIcons.retweet,
              size: Sizes.size20,
            ),
            Gaps.h10,
            FaIcon(
              FontAwesomeIcons.paperPlane,
              size: Sizes.size20,
            ),
          ],
        ),
      );
}

class ReactionInfos extends StatelessWidget {
  final ReplyDataModel? reply;
  const ReactionInfos({
    super.key,
    required this.replies,
    required this.likes,
    this.reply,
  });

  final int replies;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return reply == null
        ? Row(
            children: [
              SizedBox(
                width: 60,
                height: 50,
                child: Center(child: RepliesImageWidget(num: replies)),
              ),
              Gaps.h5,
              Opacity(
                opacity: 0.5,
                child: Text(
                  "$replies replies ・ $likes likes",
                ),
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  height: 50,
                  child: Center(
                      child: ProfileWidget(
                          profileUrl:
                              getUrl(width: 50, seed: reply!.userName))),
                ),
                // Gaps.h5,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextContentsWidget(
                              author: reply!.userName,
                              isVerifiedUser: true,
                              time: reply!.getTimeFormat(),
                              contents: reply!.comment),
                        ],
                      ),
                      Gaps.v10,
                      ReactionButtons(reply: true),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

PostCardWidget getThread(String userName) {
  return PostCardWidget(
    userName: userName,
    postData: generateFakePostData(userName),
  );
}

List<PostCardWidget> getThreads(String userName) {
  List<PostCardWidget> postCardWidgets = [];
  for (var i = 0; i < 15; i++) {
    postCardWidgets.add(getThread(userName));
  }
  postCardWidgets.sort((a, b) => a.postData.time < b.postData.time ? -1 : 1);

  return postCardWidgets;
}
