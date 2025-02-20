import 'package:threads_clone/features/home/models/post_data_model.dart';

class ReplyDataModel {
  PostDataModel postInfo;
  String userName;
  String comment;
  int time;

  ReplyDataModel({
    required this.postInfo,
    required this.userName,
    required this.comment,
    required this.time,
  });

  String getTimeFormat() {
    return time < 60 ? "${time}m" : "${(time / 60).round()}h";
  }
}
