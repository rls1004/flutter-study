import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';
import 'package:y/features/authentication/sign_up_screen.dart';
import 'package:y/features/authentication/widgets/auth_button.dart';
import 'package:y/features/authentication/widgets/common_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onPressCreateAccount(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v96,
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 35,
                ),
                child: Text(
                  'See what\'s happening in the world right now.',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.7,
                  ),
                ),
              ),
              Gaps.v96,
              AuthButton(
                  icon: FaIcon(FontAwesomeIcons.google),
                  text: 'Continue with Google'),
              AuthButton(
                  icon: FaIcon(FontAwesomeIcons.apple),
                  text: 'Continue with Apple'),
              Gaps.v5,
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 1,
                      color: Colors.black26,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('or',
                        style: TextStyle(
                          color: Colors.black87,
                        )),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 1,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: Sizes.size1,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.size14,
                  horizontal: Sizes.size40,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: Sizes.size1,
                  ),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gaps.h10,
                    GestureDetector(
                      onTap: () => onPressCreateAccount(context),
                      child: Text('Create account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: -0.5,
                            fontSize: Sizes.size20 - 2,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Gaps.v20,
              Row(
                children: [
                  Text(
                    'By signing up, you agree to our ',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'Terms',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    ', ',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    ', and ',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'Cookie Use',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    '.',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: Sizes.size24,
          ),
          child: Row(
            children: [
              Text(
                'Have an account already?',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black54,
                ),
              ),
              Gaps.h5,
              GestureDetector(
                child: Text('Log in',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: Sizes.size14,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
