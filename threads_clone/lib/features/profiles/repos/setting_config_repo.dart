import 'package:shared_preferences/shared_preferences.dart';

class SettingConfigRepository {
  static const String _darkMode = "darkMode";
  static const String _searchHistory = "searchHistory";
  final SharedPreferences _preferences;

  SettingConfigRepository(this._preferences);

  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_darkMode, value);
  }

  bool isDarkMode() {
    return _preferences.getBool(_darkMode) ?? false;
  }

  Future<void> addHistory(String value) async {
    List<String> history = _preferences.getStringList(_searchHistory) ?? [];
    if (!history.contains(value)) history.add(value);
    _preferences.setStringList(_searchHistory, history);
  }

  List<String> getHistory() {
    List<String> history = _preferences.getStringList(_searchHistory) ?? [];
    return history;
  }
}
