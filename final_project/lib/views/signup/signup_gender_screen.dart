import 'package:final_project/data/models/user_profile_model.dart';
import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/signup_view_model.dart';
import 'package:final_project/views/signup/signup_date_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupGenderScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup";
  const SignupGenderScreen({super.key});

  @override
  ConsumerState<SignupGenderScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupGenderScreen> {
  void _onTapGender(v) {
    if (ref.read(signUpProvider).isLoading) return;

    var form = ref.read(signUpForm);
    form.addAll({'gender': v});
    ref.read(signUpForm.notifier).state = form;

    Future.delayed(Duration(milliseconds: 200), () {
      if (!mounted) return;
      context.push(SignupDateScreen.routeName);
    });
  }

  bool isSelected(v) {
    return ref.read(signUpForm.notifier).state["gender"] == v;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
                "성별을 선택해주세요",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gaps.v20,
              Gaps.v80,
              Center(
                child: TextButton(
                  onPressed: () => _onTapGender(GENDER.male),
                  style: ButtonStyle(
                    shape: WidgetStateOutlinedBorder.fromMap({
                      WidgetState.any: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    }),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    overlayColor: WidgetStateColor.resolveWith(
                      (state) => Color(0xFFA9B5DF).withOpacity(0.5),
                    ),
                    backgroundColor: WidgetStateColor.resolveWith(
                      (state) =>
                          isSelected(GENDER.male)
                              ? Color(0xFFA9B5DF).withOpacity(0.5)
                              : Colors.grey.shade300,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: Sizes.size80 + Sizes.size40,

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: Sizes.size48,
                          backgroundColor: Colors.blue,
                          backgroundImage: AssetImage(
                            "assets/images/male_avatar.webp",
                          ),
                        ),
                        Gaps.h20,
                        Text(
                          "남자",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => _onTapGender(GENDER.female),
                  style: ButtonStyle(
                    shape: WidgetStateOutlinedBorder.fromMap({
                      WidgetState.any: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    }),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    overlayColor: WidgetStateColor.resolveWith(
                      (state) => Color(0xFFA9B5DF).withOpacity(0.5),
                    ),
                    backgroundColor: WidgetStateColor.resolveWith(
                      (state) =>
                          isSelected(GENDER.female)
                              ? Color(0xFFA9B5DF).withOpacity(0.5)
                              : Colors.grey.shade300,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: Sizes.size80 + Sizes.size40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: Sizes.size48,
                          backgroundColor: Colors.blue,
                          backgroundImage: AssetImage(
                            "assets/images/female_avatar.webp",
                          ),
                        ),
                        Gaps.h20,
                        Text(
                          "여자",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
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
      ),
    );
  }
}
