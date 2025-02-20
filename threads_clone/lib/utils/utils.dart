import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threads_clone/features/profiles/view_models/setting_config_vm.dart';

bool isDarkMode(BuildContext context) =>
    context.watch<SettingConfigViewModel>().darkMode;
