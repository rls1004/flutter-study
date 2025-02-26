import 'package:flutter/material.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/features/profiles/models/reply_data_model.dart';
import 'package:threads_clone/features/home/views/widgets/photo_list_widget.dart';
import 'package:threads_clone/features/home/views/widgets/post_card_widget.dart';
import 'package:threads_clone/features/home/views/widgets/profile_widget.dart';
import 'package:threads_clone/features/home/views/widgets/text_contents_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';

class ReplyWidget extends StatefulWidget {
  final ReplyDataModel replyInfo;
  const ReplyWidget({super.key, required this.replyInfo});

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
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
    replies = widget.replyInfo.postInfo.replies;
    likes = widget.replyInfo.postInfo.likes;
    time = widget.replyInfo.postInfo.time;
    timeFormat = widget.replyInfo.postInfo.getTimeFormat();
    numOfPhotos = widget.replyInfo.postInfo.numOfPhotos;

    author = widget.replyInfo.postInfo.author;
    isVerifiedUser = widget.replyInfo.postInfo.isVerifiedUser;

    contents = widget.replyInfo.postInfo.contents;
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
                                time: timeFormat,
                                contents: contents)
                          ],
                        ),
                        // if (numOfPhotos > 0)
                        //   PhotoListWidget(numOfPhotos: numOfPhotos),
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
        ReactionInfos(replies: replies, likes: likes, reply: widget.replyInfo),
        Divider(
          color: Colors.black.withOpacity(0.1),
          thickness: 0.7,
        ),
      ],
    );
  }
}

// PostCardWidget getReply(String userName) {
//   ReplyDataModel replyInfo = generateFakeReply(userName);
//   return PostCardWidget(postData: replyInfo.postInfo, replyData: replyInfo);
// }

// List<PostCardWidget> getReplies(String userName) {
//   List<PostCardWidget> postCardWidgets = [];
//   for (var i = 0; i < 15; i++) {
//     postCardWidgets.add(getReply(userName));
//   }
//   postCardWidgets
//       .sort((a, b) => a.replyData!.time < b.replyData!.time ? -1 : 1);

//   return postCardWidgets;
// }
