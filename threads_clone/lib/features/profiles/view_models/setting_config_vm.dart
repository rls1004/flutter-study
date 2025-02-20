import 'package:flutter/material.dart';
import 'package:threads_clone/features/profiles/models/setting_config_model.dart';
import 'package:threads_clone/features/profiles/repos/setting_config_repo.dart';

class SettingConfigViewModel extends ChangeNotifier {
  final SettingConfigRepository _repository;

  late final SettingConfigModel _model =
      SettingConfigModel(darkMode: _repository.isDarkMode());

  SettingConfigViewModel(this._repository);

  bool get darkMode => _model.darkMode;

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    _model.darkMode = value;
    notifyListeners();
  }
}
