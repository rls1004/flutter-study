import 'package:faker/faker.dart' as develop;

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
    "isVerifiedUser": develop.faker.randomGenerator.boolean()
  };
}

String generateFakeUserName() {
  int how = develop.faker.randomGenerator.integer(3, min: 0);

  switch (how) {
    case 0:
      String personName = develop.faker.person.name();
      personName = personName.replaceAll(" ", "_");
      return personName;

    case 1:
      List<String> words = develop.faker.lorem.words(2);
      return words[0] + words[1];

    case 2:
      return develop.faker.lorem.word() + develop.faker.animal.name();

    case 3:
      return develop.faker.color.color() + develop.faker.food.dish();

    default:
      return "rls1004";
  }
}
