class PostDataModel {
  late int replies;
  late int likes;
  late int time;
  late int numOfPhotos;

  late String author;
  late bool isVerifiedUser;

  late String contents;

  PostDataModel(
      {required this.replies,
      required this.likes,
      required this.time,
      required this.numOfPhotos,
      required this.author,
      required this.isVerifiedUser,
      required this.contents});

  String getTimeFormat() {
    return time < 60 ? "${time}m" : "${(time / 60).round()}h";
  }
}
