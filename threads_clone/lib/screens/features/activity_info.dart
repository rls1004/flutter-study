enum ActionType {
  reply,
  mention,
  follow,
  like,
}

class ActionInfo {
  late String name;
  late ActionType act;
  late String describe;
  late String actDescribe;
  late String profileUrl;
  late int time;

  ActionInfo(this.name, this.act,
      {this.describe = "", this.actDescribe = "", this.time = 0}) {
    switch (act) {
      case ActionType.reply:
        break;
      case ActionType.mention:
        describe = "Metioned you";
        break;
      case ActionType.follow:
        describe = "Followed you";
        break;
      case ActionType.like:
        break;
    }
  }
}
