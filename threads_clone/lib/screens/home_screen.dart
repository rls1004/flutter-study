import 'package:faker/faker.dart' as develop;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              size: 40,
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
            SizedBox(
              width: 6,
            ),
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
                        SizedBox(
                          height: 10,
                        ),
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

  Padding makeAuthorProfile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0.3,
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Image.network(
                  "https://picsum.photos/seed/${develop.faker.randomGenerator.numbers(100, 1)[0]}/40"),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 25,
            child: Container(
              width: 20,
              height: 20,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(45),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  )),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 12,
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
          SizedBox(
            height: 6,
          ),
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
                  SizedBox(
                    width: 4,
                  ),
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
                  SizedBox(
                    width: 10,
                  ),
                  FaIcon(
                    FontAwesomeIcons.ellipsis,
                    size: 16,
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
            SizedBox(
              width: 60,
            ),
            for (var i = 0; i < numOfPictures; i++) ...[
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                    "https://picsum.photos/seed/${develop.faker.randomGenerator.numbers(100, 1)[0]}/270/170"),
              ),
              SizedBox(
                width: 8,
              )
            ],
          ],
        ),
      ),
    );
  }

  Row makeButtonsForPost() {
    return Row(
      children: [
        SizedBox(width: 60),
        FaIcon(
          FontAwesomeIcons.heart,
          size: 22,
        ),
        SizedBox(width: 10),
        FaIcon(
          FontAwesomeIcons.comment,
          size: 22,
        ),
        SizedBox(width: 10),
        FaIcon(
          FontAwesomeIcons.retweet,
          size: 22,
        ),
        SizedBox(width: 10),
        FaIcon(
          FontAwesomeIcons.paperPlane,
          size: 22,
        ),
      ],
    );
  }

  Widget makeRepliesImg(int num) {
    if (num == 1) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0.3,
                blurRadius: 0,
              ),
            ],
          ),
          child: Image.network("https://picsum.photos/30"),
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
                top: 10,
                left: 10,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0.3,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Image.network(
                      "https://picsum.photos/id/${develop.faker.randomGenerator.decimal(scale: 50, min: 0).round()}/20"),
                ),
              ),
              Positioned(
                top: 10,
                left: 25,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 3,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 25,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0.3,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Image.network(
                      "https://picsum.photos/id/${develop.faker.randomGenerator.decimal(scale: 50, min: 0).round()}/20"),
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
              left: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0.3,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Image.network("https://picsum.photos/id/1/16"),
                ),
              ),
            ),
            Positioned(
              left: 30,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0.3,
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Image.network("https://picsum.photos/id/2/20"),
              ),
            ),
            Positioned(
              top: 23,
              left: 25,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0.3,
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Image.network("https://picsum.photos/id/3/13"),
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
        SizedBox(
          width: 5,
        ),
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
