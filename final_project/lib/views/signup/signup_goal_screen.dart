import 'package:final_project/data/models/user_profile_model.dart';
import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/signup_view_model.dart';
import 'package:final_project/views/signup/signup_username_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupGoalScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup/goal";

  const SignupGoalScreen({super.key});

  @override
  ConsumerState<SignupGoalScreen> createState() => _SignupGoalScreenState();
}

class _SignupGoalScreenState extends ConsumerState<SignupGoalScreen> {
  Map<String, GOAL> pathes = {
    "긍정적인 순간 기록": GOAL.writePositive,
    "스트레스 관리": GOAL.manageStress,
    "감정 분석": GOAL.analysisEmotion,
  };
  GOAL _selected = GOAL.none;

  void onTapButton(v) {
    _selected = v;
    setState(() {});

    var form = ref.read(signUpForm);
    form.addAll({'goal': v});
    ref.read(signUpForm.notifier).state = form;

    Future.delayed(Duration(milliseconds: 200), () {
      if (!mounted) return;
      context.push(SignupUsernameScreen.routeName);
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
              "어떤 목적으로\n사용하고 싶나요?",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Gaps.v20,

            for (var entry in pathes.entries)
              Center(
                child: TextButton(
                  onPressed: () => onTapButton(entry.value),
                  style: ButtonStyle(
                    shape: WidgetStateOutlinedBorder.fromMap({
                      WidgetState.any: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    }),
                    backgroundColor: WidgetStateColor.resolveWith(
                      (state) =>
                          _selected == entry.value
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
                          " ${entry.key}",
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
