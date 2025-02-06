import 'package:faker/faker.dart' as develop;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/screens/widgets/bottom_menu_widget.dart';
import 'package:threads_clone/screens/widgets/fake_generator.dart';
import 'package:threads_clone/screens/widgets/profile_widget.dart';

class PostViewWidget extends StatefulWidget {
  final int index;
  const PostViewWidget({super.key, required this.index});

  @override
  State<PostViewWidget> createState() => _PostViewWidgetState();
}

class _PostViewWidgetState extends State<PostViewWidget> {
  late Map<String, Object> fakeData;
  late int replies;
  late int likes;
  late String time;
  late int numOfPhotos;

  late String author;
  late bool isVerifiedUser;

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
  }

  void _onMenusTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomMenuWidget(),
    );
  }

  Expanded representAuthorAndText(
      BuildContext context, String author, bool isVerified, String time) {
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
                  if (isVerified)
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
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w500,
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
            develop.faker.lorem.sentences(1)[0],
          ),
        ],
      ),
    );
  }

  SizedBox representPhotos(int numOfPictures) {
    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Gaps.h60,
            for (var i = 0; i < numOfPictures; i++) ...[
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 0.5,
                    )),
                child: Image.network(getUrl(width: 270, height: 170)),
              ),
              Gaps.h8,
            ],
          ],
        ),
      ),
    );
  }

  Row makeButtonsForPost() {
    return Row(
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

  Widget makeRepliesImg(int num) {
    if (num == 1) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
              width: 0.3,
            ),
          ),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(getUrl(width: 40)),
          ),
        ),
      );
    } else if (num == 2) {
      return Center(
        child: SizedBox(
          width: 54,
          height: 50,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 15,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 0.3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(getUrl(width: 40)),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 25,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.3),
                        width: 0.3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(getUrl(width: 40)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (num >= 3) {
      return SizedBox(
        width: 54,
        height: 50,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 13,
              left: 8,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.3),
                    width: 0.3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundImage: NetworkImage(getUrl(width: 40)),
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 30,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.3),
                    width: 0.3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(getUrl(width: 40)),
                ),
              ),
            ),
            Positioned(
              top: 28,
              left: 25,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.3),
                    width: 0.3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 6.5,
                  backgroundImage: NetworkImage(getUrl(width: 40)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: 54,
      height: 50,
    );
  }

  Row makeReactions(int replies, int likes) {
    return Row(
      children: [
        makeRepliesImg(replies > 3 ? 3 : replies),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.index > 0)
          Divider(
            color: Colors.black.withOpacity(0.1),
            thickness: 0.7,
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileWidget(
              profileUrl: getUrl(width: 60),
              withPlusButton: true,
            ),
            Gaps.h6,
            representAuthorAndText(context, author, isVerifiedUser, time)
          ],
        ),
        IntrinsicHeight(
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.1),
                    thickness: 1.5,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (numOfPhotos > 0) representPhotos(numOfPhotos),
                        Gaps.v10,
                        makeButtonsForPost()
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        makeReactions(replies, likes),
      ],
    );
  }
}
