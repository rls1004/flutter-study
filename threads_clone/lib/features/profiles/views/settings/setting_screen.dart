import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/profiles/view_models/setting_config_vm.dart';
import 'package:threads_clone/features/profiles/views/settings/privacy_screen.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';

class SettingScreen extends ConsumerWidget {
  static const routeName = "/settings";
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.angleLeft,
                  size: Sizes.size14,
                ),
                Gaps.h5,
                Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(height: 0, thickness: 0.3, color: Colors.grey),
        ),
      ),
      body: Column(
        spacing: 10,
        children: [
          Gaps.v2,
          SwitchListTile.adaptive(
            thumbColor: WidgetStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor),
            inactiveTrackColor: Colors.grey,
            activeColor: ref.watch(settingConfigProvider).darkMode
                ? Colors.white
                : Colors.black,
            value: ref.watch(settingConfigProvider).darkMode,
            onChanged: (value) =>
                ref.read(settingConfigProvider.notifier).setDarkMode(value),
            title: Text(
              ref.watch(settingConfigProvider).darkMode
                  ? "Dark Mode"
                  : "Light Mode",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            secondary: Icon(
              ref.watch(settingConfigProvider).darkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
              size: Sizes.size28,
            ),
          ),
          ListTile(
            minTileHeight: 0,
            leading: Icon(
              Icons.person_add_outlined,
              size: Sizes.size28,
            ),
            title: Text(
              "Follow and invite friends",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          ),
          ListTile(
            minTileHeight: 0,
            leading: Icon(
              Icons.notifications_none,
              size: Sizes.size28,
            ),
            title: Text(
              "Notifications",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          ),
          ListTile(
            minTileHeight: 0,
            leading: Icon(
              Icons.lock_outline,
              size: Sizes.size28,
            ),
            title: Text(
              "Privacy",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            onTap: () => context.push(PrivacyScreen.routeName),
          ),
          ListTile(
            minTileHeight: 0,
            leading: Icon(
              Icons.account_circle_outlined,
              size: Sizes.size28,
            ),
            title: Text(
              "Account",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          ),
          ListTile(
            minTileHeight: 0,
            leading: Icon(
              Icons.support,
              size: Sizes.size28,
            ),
            title: Text(
              "Help",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          ),
          ListTile(
            minTileHeight: 0,
            leading: Icon(
              Icons.info_outline,
              size: Sizes.size28,
            ),
            title: Text(
              "About",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          ),
          Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
          ListTile(
            minTileHeight: 0,
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.blue,
                fontSize: Sizes.size14,
              ),
            ),
            onTap: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        title: Text("Are you sure?"),
                        content: Text("Plz dont go"),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("No"),
                          ),
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            isDestructiveAction: true,
                            child: Text("Yes"),
                          ),
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }
}
