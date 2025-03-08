import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/views/signup/signup_goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupSurveyScreen extends StatefulWidget {
  static const routeName = "/signup/survey";

  const SignupSurveyScreen({super.key});

  @override
  State<SignupSurveyScreen> createState() => _SignupSurveyScreenState();
}

class _SignupSurveyScreenState extends State<SignupSurveyScreen> {
  List<String> pathes = [
    "광고에서 봤어요",
    "우연히 발견했어요",
    "검색하다 알게 됐어요",
    "지인이 추천했어요",
    "기타",
  ];
  int _selected = -1;

  void onTapButton(v) {
    _selected = v;
    setState(() {});

    Future.delayed(Duration(milliseconds: 200), () {
      if (!mounted) return;
      context.push(SignupGoalScreen.routeName);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size20,
        ),
        child: Column(
          spacing: Sizes.size10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "이 앱을 어떻게 알게 됐나요?",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Gaps.v20,

            for (var (index, path) in pathes.indexed)
              Center(
                child: TextButton(
                  onPressed: () => onTapButton(index),
                  style: ButtonStyle(
                    shape: WidgetStateOutlinedBorder.fromMap({
                      WidgetState.any: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    }),
                    backgroundColor: WidgetStateColor.resolveWith(
                      (state) =>
                          _selected == index
                              ? Color(0xFFA9B5DF)
                              : Colors.grey.shade300,
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: Sizes.size40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " $path",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
