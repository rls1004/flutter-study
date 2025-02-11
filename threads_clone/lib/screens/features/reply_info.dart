import 'package:threads_clone/screens/features/post_info.dart';

class ReplyInfo {
  PostInfo postInfo;
  String userName;
  String comment;
  int time;

  ReplyInfo({
    required this.postInfo,
    required this.userName,
    required this.comment,
    required this.time,
  });

  String getTimeFormat() {
    return time < 60 ? "${time}m" : "${(time / 60).round()}h";
  }
}
