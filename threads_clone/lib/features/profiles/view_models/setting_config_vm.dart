import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/features/profiles/models/setting_config_model.dart';
import 'package:threads_clone/features/profiles/repos/setting_config_repo.dart';

class SettingConfigViewModel extends Notifier<SettingConfigModel> {
  final SettingConfigRepository _repository;
  SettingConfigViewModel(this._repository);

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = SettingConfigModel(darkMode: value);
  }

  void addHistory(String value) {
    _repository.addHistory(value);
    state = SettingConfigModel(
        darkMode: _repository.isDarkMode(),
        searchHistory: _repository.getHistory());
  }

  @override
  SettingConfigModel build() {
    return SettingConfigModel(darkMode: _repository.isDarkMode());
  }
}

final settingConfigProvider =
    NotifierProvider<SettingConfigViewModel, SettingConfigModel>(
  () => throw UnimplementedError(),
);
