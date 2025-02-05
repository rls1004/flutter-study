import 'package:faker/faker.dart' as develop;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: FaIcon(
              FontAwesomeIcons.threads,
              size: Sizes.size40,
              color: Colors.black,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: getPost(index),
              ),
              childCount: 15,
            ),
          ),
        ],
      ),
    );
  }

  getUrl(int width, [int? height]) => develop.faker.image.loremPicsum(
      width: width,
      height: height ?? width,
      random: develop.faker.randomGenerator.numbers(100, 1)[0]);

  Widget getPost(int i) {
    List<int> randomNumber = develop.faker.randomGenerator.numbers(300, 2);
    int replies = randomNumber[0];
    int likes = randomNumber[1];

    if (replies % 2 == 0) {
      replies = develop.faker.randomGenerator.numbers(3, 1)[0];
    }

    int randomTime =
        i * 6 + develop.faker.randomGenerator.numbers((i + 1) * 6, 1)[0];
    String time =
        randomTime < 60 ? "${randomTime}m" : "${(randomTime / 60).round()}h";

    int numOfPhothos = develop.faker.randomGenerator.numbers(5, 1)[0];

    return Column(
      children: [
        if (i > 0)
          Divider(
            color: Colors.black.withOpacity(0.1),
            thickness: 0.7,
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            makeAuthorProfile(),
            Gaps.h6,
            representAuthorAndText(time)
          ],
        ),
        IntrinsicHeight(
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.12),
                    thickness: 2,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (numOfPhothos > 0) representPhotos(numOfPhothos),
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

  Padding makeAuthorProfile({bool withPlusButton = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(getUrl(40)),
            ),
          ),
          if (withPlusButton)
            Positioned(
              bottom: 0,
              left: 27,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.black,
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: Sizes.size10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Expanded representAuthorAndText(String time) {
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
                    develop.faker.person.name(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.h4,
                  if (develop.faker.randomGenerator.boolean())
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
                  FaIcon(
                    FontAwesomeIcons.ellipsis,
                    size: Sizes.size16,
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(getUrl(270, 170)),
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
        Gaps.h60,
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
            backgroundImage: NetworkImage(getUrl(30)),
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
                    backgroundImage: NetworkImage(getUrl(10)),
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
                      backgroundImage: NetworkImage(getUrl(10)),
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
                  backgroundImage: NetworkImage(getUrl(16)),
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
                  backgroundImage: NetworkImage(getUrl(20)),
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
                  backgroundImage: NetworkImage(getUrl(13)),
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
}
