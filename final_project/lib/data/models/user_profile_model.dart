enum GENDER {
  none,
  male,
  female;

  String toJson() => name;
  static GENDER fromJson(String json) => values.byName(json);
}

enum GOAL {
  none,
  writePositive,
  manageStress,
  analysisEmotion;

  String toJson() => name;
  static GOAL fromJson(String json) => values.byName(json);
}

class UserProfileModel {
  final String uid;
  final String email;
  final String username;
  final GENDER gender;
  final String birth;
  final GOAL goal;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.gender,
    required this.birth,
    required this.goal,
  });

  UserProfileModel.empty()
    : uid = "",
      email = "",
      username = "",
      gender = GENDER.none,
      birth = "",
      goal = GOAL.none;

  UserProfileModel.fromJson(Map<String, dynamic> json)
    : uid = json["uid"],
      email = json["email"],
      username = json["usernmae"],
      gender = GENDER.fromJson(json["gender"]),
      birth = json["birth"],
      goal = GOAL.fromJson(json["goal"]);

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "usernmae": username,
      "gender": gender.toJson(),
      "birth": birth,
      "goal": goal.toJson(),
    };
  }
}
