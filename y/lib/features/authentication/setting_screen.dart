import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';
import 'package:y/features/authentication/sign_up_screen.dart';
import 'package:y/features/authentication/widgets/common_widget.dart';

class SettingScreen extends StatefulWidget {
  final String? name;
  final String? email;
  final String? dateOfBirth;

  const SettingScreen({super.key, this.name, this.email, this.dateOfBirth});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isSwitched = true;

  void _onSwitch(bool newValue) {
    setState(() {
      _isSwitched = newValue;
    });
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpScreen(
          settingAgree: _isSwitched,
          name: widget.name,
          email: widget.email,
          dateOfBirth: widget.dateOfBirth,
        ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v14,
              Text(
                'Customize your experience',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gaps.v20,
              Text(
                'Track where you see Twitter content across the web',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              Gaps.v14,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        letterSpacing: -0.4,
                      ),
                      softWrap: true,
                    ),
                  ),
                  Switch(
                    value: _isSwitched,
                    onChanged: _onSwitch,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green.shade500,
                  ),
                ],
              ),
              Gaps.v28,
              Wrap(
                children: [
                  normalText('By signing up, you agree to our '),
                  linkText(context, 'Terms'),
                  normalText(', '),
                  linkText(context, 'Privacy Policy'),
                  normalText(', and '),
                  linkText(context, 'Cookie Use'),
                  normalText('. Twitter may'),
                  normalText(
                      'use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. '),
                  linkText(context, 'Learn more'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNext(_onNextTap),
    );
  }
}
