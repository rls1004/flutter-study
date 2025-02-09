import 'dart:math';
import 'package:faker/faker.dart' as develop;
import 'package:threads_clone/screens/features/activity_info.dart';
import 'package:threads_clone/screens/features/search_info.dart';

getUrl({required int width, int? height, String? seed}) =>
    develop.faker.image.loremPicsum(
      width: width,
      height: height ?? width,
      seed: seed ?? develop.faker.animal.name(),
      random: seed?.length ?? develop.faker.randomGenerator.numbers(100, 1)[0],
    );

Map<String, Object> generateFakePostData(int seed) {
  List<int> randomNumber = develop.faker.randomGenerator.numbers(300, 2);

  int replies = randomNumber[0];
  int likes = randomNumber[1];
  if (replies % 2 == 0) {
    replies = develop.faker.randomGenerator.numbers(3, 1)[0];
  }
  int randomTime =
      seed * 6 + develop.faker.randomGenerator.numbers((seed + 1) * 6, 1)[0];
  String time =
      randomTime < 60 ? "${randomTime}m" : "${(randomTime / 60).round()}h";
  int numOfPhotos = develop.faker.randomGenerator.numbers(5, 1)[0];

  String author = generateFakeUserName();

  return {
    "replies": replies,
    "likes": likes,
    "time": time,
    "numOfPhotos": numOfPhotos,
    "author": author,
    "isVerifiedUser": develop.faker.randomGenerator.boolean(),
    "contents": develop.faker.lorem.sentences(1)[0],
  };
}

String generateFakeUserName() {
  int how = develop.faker.randomGenerator.integer(3, min: 0);
  String userName = "";

  switch (how) {
    case 0:
      String personName = develop.faker.person.name();
      userName = personName.replaceAll(" ", "_");

    case 1:
      List<String> words = develop.faker.lorem.words(2);
      userName = words[0] + words[1];

    case 2:
      userName = develop.faker.lorem.word() + develop.faker.animal.name();

    case 3:
      userName = develop.faker.color.color() + develop.faker.food.dish();

    default:
      userName = "rls1004";
  }

  if (userName.isNotEmpty && userName.length <= 15) return userName;
  return generateFakeUserName();
}

SearchInfo generateFakeUserList() {
  String userName = generateFakeUserName();
  String realName = develop.faker.person.name();

  int followersNumber = develop.faker.randomGenerator.numbers(999, 1)[0];

  return SearchInfo(userName, realName, followersNumber);
}

ActionInfo generateFakeActivity() {
  String name = generateFakeUserName();
  List<ActionType> actionList = [
    ActionType.reply,
    ActionType.mention,
    ActionType.follow,
    ActionType.like
  ];
  ActionType act = actionList[Random().nextInt(4)];

  String describe = develop.faker.lorem.sentence();
  String actDescribe = develop.faker.lorem.sentence();
  if (act == ActionType.follow || act == ActionType.like) {
    actDescribe = "";
  }

  int time = develop.faker.randomGenerator.integer(24 * 60);

  return ActionInfo(
    name,
    act,
    describe: describe,
    actDescribe: actDescribe,
    time: time,
  );
}
