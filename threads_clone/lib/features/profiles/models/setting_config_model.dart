class SettingConfigModel {
  bool darkMode;
  List<String> searchHistory;

  SettingConfigModel({required this.darkMode, this.searchHistory = const []});
}
