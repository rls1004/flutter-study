class PostModel {
  final String description;
  final String creatorUid;
  final String creator;
  final int likes;
  final int comments;
  final int createdAt;
  final bool hasAttachments;
  final String? postID;
  List<String> attachments = [];

  PostModel({
    required this.description,
    required this.creatorUid,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.creator,
    required this.hasAttachments,
    this.postID,
  });

  PostModel.fromJson(Map<String, dynamic> json, String postId)
      : description = json["description"],
        creatorUid = json["creatorUid"],
        likes = json["likes"],
        comments = json["comments"],
        createdAt = json["createdAt"],
        creator = json["creator"],
        hasAttachments = json["hasAttachments"],
        postID = postId;

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "creatorUid": creatorUid,
      "likes": likes,
      "comments": comments,
      "createdAt": createdAt,
      "creator": creator,
      "hasAttachments": hasAttachments,
    };
  }

  void setAttachment(List<String> fileList) {
    attachments = fileList;
  }
}

class PostImageModel {
  final String postId;
  final String fileUrl;
  final String creatorUid;
  final String creator;
  final int createdAt;
  final int number;

  PostImageModel({
    required this.postId,
    required this.fileUrl,
    required this.creatorUid,
    required this.createdAt,
    required this.creator,
    required this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      "postId": postId,
      "number": number,
      "fileUrl": fileUrl,
      "creatorUid": creatorUid,
      "createdAt": createdAt,
      "creator": creator,
    };
  }
}
