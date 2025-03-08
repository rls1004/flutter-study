import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/views/signin/signin_screen.dart';
import 'package:final_project/views/signup/signup_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  static const routeName = "/start";

  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    onTapSignup() {
      print(SignupEmailScreen.routeName);
      context.push(SignupEmailScreen.routeName);
    }

    return Scaffold(
      body: Column(
        spacing: Sizes.size20,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTapSignup,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: Sizes.size52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "시작하기",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "이미 계정이 있다면? ",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.7),
                  ),
                ),
                child: GestureDetector(
                  onTap: () => context.push(SigninScreen.routeName),
                  child: Text(
                    "로그인",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ],
          ),
          Gaps.v64,
        ],
      ),
    );
  }
}
