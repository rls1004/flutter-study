import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';
import 'package:y/features/authentication/utils/utils.dart';
import 'package:y/features/authentication/widgets/form_button.dart';

typedef CategoryProperty = Map<String, dynamic>;
typedef Category = Map<String, CategoryProperty>;
typedef Interests = Map<String, bool>;

Category categories = {
  "Daily Life": {"isSelected": false, "details": dayliLife},
  "Comedy": {"isSelected": false, "details": empty},
  "Entertainment": {"isSelected": false, "details": entertainments},
  "Animals": {"isSelected": false, "details": empty},
  "Food": {"isSelected": false, "details": empty},
  "Beauty & Style": {"isSelected": false, "details": empty},
  "Music": {"isSelected": false, "details": musics},
  "Learning": {"isSelected": false, "details": empty},
  "Talent": {"isSelected": false, "details": empty},
  "Sports": {"isSelected": false, "details": empty},
  "Auto": {"isSelected": false, "details": empty},
  "Family": {"isSelected": false, "details": empty},
  "Fitness & Health": {"isSelected": false, "details": empty},
  "DIY & Life Hacks": {"isSelected": false, "details": empty},
  "Arts & Crafts": {"isSelected": false, "details": empty},
  "Dance": {"isSelected": false, "details": empty},
  "Outdoors": {"isSelected": false, "details": empty},
  "Oddly Satisfying": {"isSelected": false, "details": empty},
  "Home & Garden": {"isSelected": false, "details": empty},
};

Interests empty = {
  "Empty": false,
};
Interests musics = {
  "Rap": false,
  "R&B & sourl": false,
  "Grammy Awards": false,
  "Pop": false,
  "K-pop": false,
  "Music industry": false,
  "EDM": false,
  "Music news": false,
  "Hip hop": false,
  "Reggae": false,
  "Classic": false,
  "J-pop": false,
  "Heavy metal": false,
  "Jazz": false,
  "Rock": false,
  "Opera": false,
  "Folk": false,
  "Dance": false,
};
Interests entertainments = {
  "Anime": false,
  "Movies & TV": false,
  "Harry Potter": false,
  "Marvel Universe": false,
  "Movie news": false,
  "Naruto": false,
  "Movies": false,
  "Grammy Awards": false,
  "Entertainment": false,
  "Band": false,
  "Orchestra": false,
  "Choir": false,
  "Jazz band": false,
  "Tesla": false,
};
Interests dayliLife = {
  "Eat": false,
  "Sleep": false,
  "Code": false,
  "Repeat": false,
};

class InterestsScreen extends StatefulWidget {
  int interestPart;
  InterestsScreen({super.key, this.interestPart = 1});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _partOneTotalSelect = 0;
  int _partTwoeTotalSelect = 0;

  @override
  void initState() {
    super.initState();
    initInterests();
    _partTwoeTotalSelect = 0;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void initInterests() {
    for (var category in categories.values.toList()) {
      var interests = category['details'];
      for (var interest in interests.keys) {
        interests[interest] = false;
      }
      interests.values;
    }
  }

  void _onTap(String interest) {
    setState(() {
      if (categories[interest]!["isSelected"] == false) {
        if (_partOneTotalSelect == 3) return;
        _partOneTotalSelect++;
      } else {
        _partOneTotalSelect--;
      }
      categories[interest]!["isSelected"] =
          !categories[interest]!["isSelected"]!;
    });
  }

  void _onInterestTap(String category, String interest) {
    setState(() {
      categories[category]!["details"][interest] =
          !categories[category]!["details"][interest];
      _partTwoeTotalSelect += 1;
    });
  }

  void _onNextTap() {
    if (_partOneTotalSelect < 3) return;
    if (widget.interestPart == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InterestsScreen(
            interestPart: 2,
          ),
        ),
      );
    }
  }

  List<String> separateList(Interests interests, int i) {
    var interestsList = interests.keys.toList();
    int itemPerLine = (interestsList.length / 3).toInt();
    int restItems = interestsList.length - itemPerLine * 3;
    if (i == 0) {
      itemPerLine += restItems;
    }
    int start = i * itemPerLine;
    int end = (i + 1) * itemPerLine;

    if (i != 0) {
      start += restItems;
      end += restItems;
    }

    if (end >= interestsList.length) end = interestsList.length;

    if (i != 0 && start < (i) * (interestsList.length / 3).toInt()) return [];

    return interestsList.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(canPop: widget.interestPart == 1 ? false : true),
      body: SafeArea(
        child: Scrollbar(
          child: widget.interestPart == 1
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v14,
                        Text(
                          'What do you want to see on Twitter?',
                          style: TextStyle(
                            fontSize: Sizes.size24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Gaps.v16,
                        normalText(
                            'Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.'),
                        Center(
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: [
                              for (var interest in categories.keys)
                                makeCategoryButton(context, interest,
                                    categories[interest]!["isSelected"], _onTap)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v14,
                        Text(
                          'What do you want to see on Twitter?',
                          style: TextStyle(
                            fontSize: Sizes.size24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Gaps.v16,
                        normalText(
                            'Interests are used to personalize your experience and will be visible on your profile.'),
                        Gaps.v16,
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                          ],
                        ),
                        for (var subject in categories.entries
                            .where((e) => e.value["isSelected"] == true))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gaps.v16,
                              Text(
                                subject.key,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                              Gaps.v20,
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                height: 170,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        for (int i = 0; i < 3; i++)
                                          Row(
                                            spacing: 8,
                                            children: [
                                              for (var interest in separateList(
                                                  subject.value["details"], i))
                                                makeInterestButton(
                                                  context,
                                                  subject.key,
                                                  interest,
                                                  subject.value["details"]
                                                      [interest],
                                                  _onInterestTap,
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size32,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.interestPart == 1
                  ? (_partOneTotalSelect < 3
                      ? '$_partOneTotalSelect of 3 selected'
                      : 'Great work 🎉')
                  : ''),
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                    disabled: widget.interestPart == 1
                        ? (_partOneTotalSelect < 3 ? true : false)
                        : (_partTwoeTotalSelect < 3 ? true : false)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

GestureDetector makeCategoryButton(
    BuildContext context, String interest, bool isSelected, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(interest),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        vertical: Sizes.size10,
        horizontal: Sizes.size10,
      ),
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size10),
        border: Border.all(
            color:
                isSelected ? Colors.transparent : Colors.black.withOpacity(0.2),
            width: 1),
      ),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: FaIcon(
              FontAwesomeIcons.solidCircleCheck,
              size: Sizes.size16,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              interest,
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ),
  );
}

GestureDetector makeInterestButton(BuildContext context, String category,
    String interest, bool isSelected, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(category, interest),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        vertical: Sizes.size8,
        horizontal: Sizes.size16,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size24),
        border: Border.all(
          color:
              isSelected ? Colors.transparent : Colors.black.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          interest,
          style: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
