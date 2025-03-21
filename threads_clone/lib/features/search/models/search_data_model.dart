class SearchDataModel {
  String userName;
  String realName;
  int followers;
  SearchDataModel(this.userName, this.realName, this.followers);

  String followersToString() {
    String followersStr = "${followers ~/ 10}";
    followersStr += followers % 10 == 0 ? "K" : ".${followers % 10}K";
    return followersStr;
  }
}
