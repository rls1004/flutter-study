import 'package:final_project/data/models/user_profile_model.dart';
import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/analysis_view_model.dart';
import 'package:final_project/view_models/users_view_model.dart';
import 'package:final_project/views/profile/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const routeName = "/profile";
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int cardsTotal = 0;
  int highestRecordByDay = 0;
  List<int> summaryStats = [0, 0, 0, 0];
  final List<String> _emojiList = ["😆", "☺️", "😶‍🌫️", "😢", "😡"];

  @override
  void initState() {
    super.initState();
  }

  void _onTapMenu() {
    Navigator.of(
      context,
      rootNavigator: true,
    ).push(MaterialPageRoute(builder: (context) => SettingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Future(() async {
      summaryStats =
          await ref.read(analysisProvider.notifier).fetchSummaryStats();
      setState(() {});
    });
    return ref
        .watch(usersProvider)
        .when(
          loading: () => Container(),
          error: (error, stackTrace) => Container(),
          data: (data) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                  child: Column(
                    spacing: Sizes.size10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: _onTapMenu,
                            child: Icon(Icons.menu_rounded, size: Sizes.size32),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFA9B5DF),
                            radius: Sizes.size40,
                            backgroundImage: AssetImage(
                              data.gender == GENDER.male
                                  ? "assets/images/male_avatar.webp"
                                  : "assets/images/female_avatar.webp",
                            ),
                          ),
                          Gaps.h20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.username} 님",
                                style: TextStyle(
                                  fontSize: Sizes.size28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment(0, 0.5),
                                    width: Sizes.size36,
                                    height: Sizes.size24,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size7,
                                      ),
                                    ),
                                    child: Text(
                                      "새싹",
                                      style: TextStyle(
                                        fontSize: Sizes.size14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      Divider(color: Colors.grey.shade200),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: Sizes.size80 + Sizes.size80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(Sizes.size10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                height: Sizes.size80 + Sizes.size20,
                                width: Sizes.size80 + Sizes.size20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size10,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: Sizes.size5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "총 기록",
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    Text(
                                      "${summaryStats[0]}",
                                      style: TextStyle(
                                        fontSize: Sizes.size20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Gaps.v3,
                                    Container(
                                      alignment: Alignment(0, 0.5),
                                      width: Sizes.size36,
                                      height: Sizes.size24,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade300,
                                        borderRadius: BorderRadius.circular(
                                          Sizes.size7,
                                        ),
                                      ),
                                      child: Text(
                                        "보통",
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: Sizes.size80 + Sizes.size20,
                                width: Sizes.size80 + Sizes.size20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size10,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: Sizes.size5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "최고 기록",
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    Text(
                                      "${summaryStats[1]}",
                                      style: TextStyle(
                                        fontSize: Sizes.size20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Gaps.v3,
                                    Container(
                                      alignment: Alignment(0, 0.5),
                                      width: Sizes.size36,
                                      height: Sizes.size24,
                                      decoration: BoxDecoration(
                                        color: Colors.pink.shade300,
                                        borderRadius: BorderRadius.circular(
                                          Sizes.size7,
                                        ),
                                      ),
                                      child: Text(
                                        "많음",
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: Sizes.size80 + Sizes.size20,
                                width: Sizes.size80 + Sizes.size20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size10,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: Sizes.size5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "대표 감정",
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        color: Colors.grey.shade700,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      _emojiList[summaryStats[2]],
                                      style: TextStyle(
                                        fontSize: Sizes.size32,
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      "${summaryStats[3]}회 사용했어요!",
                                      style: TextStyle(
                                        fontSize: Sizes.size10,
                                        color: Colors.grey.shade700,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
