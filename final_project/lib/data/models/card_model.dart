class CardModel {
  final String contents;
  final String creatorUid;
  final String creator;
  final int recordTime;
  final int createdAt;
  final int emoji;
  final String? postID;

  CardModel({
    required this.recordTime,
    required this.emoji,
    required this.contents,
    required this.creatorUid,
    required this.createdAt,
    required this.creator,
    this.postID,
  });

  CardModel.fromJson(Map<String, dynamic> json, String postId)
    : recordTime = json["selectedTime"],
      emoji = json["emoji"],
      contents = json["contents"],
      creatorUid = json["creatorUid"],
      createdAt = json["createdAt"],
      creator = json["creator"],
      postID = postId;

  Map<String, dynamic> toJson() {
    return {
      "selectedTime": recordTime,
      "emoji": emoji,
      "contents": contents,
      "creatorUid": creatorUid,
      "createdAt": createdAt,
      "creator": creator,
    };
  }
}
