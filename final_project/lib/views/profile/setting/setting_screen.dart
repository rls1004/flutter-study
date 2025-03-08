import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/users_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerStatefulWidget {
  static const routeName = "/profile/setting";
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "설정",
          style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "내 정보",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v10,
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(Sizes.size10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text("계정"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: Sizes.size20,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    title: Text("계정"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: Sizes.size20,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    title: Text("계정"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: Sizes.size20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Gaps.v32,
            Text(
              "기타",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v10,
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(Sizes.size10),
              ),
              child: Column(
                children: [
                  ListTile(title: Text("앱 버전"), trailing: Text("1.0.0")),
                  ListTile(
                    title: Text("탈퇴하기"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: Sizes.size20,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    onTap:
                        () => showCupertinoDialog(
                          context: context,
                          builder:
                              (context) => CupertinoAlertDialog(
                                title: Text("로그아웃 하시겠습니까?"),
                                // content: Text(""),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    child: Text("아니오"),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed:
                                        () =>
                                            ref
                                                .read(usersProvider.notifier)
                                                .logout(),
                                    isDestructiveAction: true,
                                    child: Text("네"),
                                  ),
                                ],
                              ),
                        ),
                    title: Text("로그아웃"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: Sizes.size20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
