import 'package:threads_clone/models/post_model.dart';

class ReplyModel {
  PostModel postInfo;
  String userName;
  String comment;
  int time;

  ReplyModel({
    required this.postInfo,
    required this.userName,
    required this.comment,
    required this.time,
  });

  String getTimeFormat() {
    return time < 60 ? "${time}m" : "${(time / 60).round()}h";
  }
}
