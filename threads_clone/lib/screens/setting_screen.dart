import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class SettingScreen extends StatelessWidget {
  final Function onTapBack;
  final Function onTapPrivacy;
  const SettingScreen(
      {super.key, required this.onTapBack, required this.onTapPrivacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0.2,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () => onTapBack(),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Colors.black,
                size: Sizes.size14,
              ),
              Gaps.h5,
              Text(
                "Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          spacing: 10,
          children: [
            Gaps.v2,
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
              onTap: () => onTapPrivacy(),
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
              color: Colors.black.withOpacity(0.3),
              thickness: 0.3,
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
      ),
    );
  }
}
