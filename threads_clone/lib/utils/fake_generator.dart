import 'dart:math';
import 'package:faker/faker.dart' as develop;
import 'package:threads_clone/features/activities/models/activity_data_model.dart';
import 'package:threads_clone/features/home/models/post_data_model.dart';
import 'package:threads_clone/features/profiles/models/reply_data_model.dart';
import 'package:threads_clone/features/search/models/search_data_model.dart';

getUrl({required int width, int? height, String? seed}) =>
    develop.faker.image.loremPicsum(
      width: width,
      height: height ?? width,
      seed: seed ?? develop.faker.animal.name(),
      random: seed?.length ?? develop.faker.randomGenerator.numbers(100, 1)[0],
    );

PostDataModel generateFakePostData(String userName) {
  List<int> randomNumber = develop.faker.randomGenerator.numbers(300, 2);

  int replies = randomNumber[0];
  int likes = randomNumber[1];
  if (replies % 2 == 0) {
    replies = develop.faker.randomGenerator.numbers(3, 1)[0];
  }
  int time = develop.faker.randomGenerator.numbers(60 * 24, 1)[0];

  int numOfPhotos = develop.faker.randomGenerator.numbers(5, 1)[0];

  String author = userName.isEmpty ? generateFakeUserName() : userName;

  bool isVerifiedUser = [true, false][author.hashCode % 2];
  String contents = develop.faker.lorem.sentences(1)[0];

  return PostDataModel(
      replies: replies,
      likes: likes,
      time: time,
      numOfPhotos: numOfPhotos,
      author: author,
      isVerifiedUser: isVerifiedUser,
      contents: contents);
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

SearchDataModel generateFakeUserList() {
  String userName = generateFakeUserName();
  String realName = develop.faker.person.name();

  int followersNumber = develop.faker.randomGenerator.numbers(999, 1)[0];

  return SearchDataModel(userName, realName, followersNumber);
}

ActivityDataModel generateFakeActivity() {
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

  return ActivityDataModel(
    name,
    act,
    describe: describe,
    actDescribe: actDescribe,
    time: time,
  );
}

ReplyDataModel generateFakeReply(String userName) {
  PostDataModel fakePost = generateFakePostData("");
  String comment = develop.faker.lorem.sentences(1)[0];
  int time = develop.faker.randomGenerator.numbers(60 * 24, 1)[0];

  return ReplyDataModel(
      postInfo: fakePost,
      userName: userName.isEmpty ? generateFakeUserName() : userName,
      comment: comment,
      time: time);
}
