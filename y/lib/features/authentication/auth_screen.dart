import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';
import 'package:y/features/authentication/password_screen.dart';
import 'package:y/features/authentication/utils/utils.dart';

class AuthScreen extends StatefulWidget {
  final bool? settingAgree;
  final String? name;
  final String? email;
  final String? dateOfBirth;

  const AuthScreen({
    super.key,
    this.settingAgree,
    this.name,
    this.email,
    this.dateOfBirth,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _onEditing = true;
  String? _code;
  bool _isCodeValid = false;

  void _onNextTap() {
    if (!_isCodeValid) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PasswordScreen(),
      ),
    );
  }

  void _checkCode(String code) {
    _isCodeValid = _code?.length == 6;
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
                'We sent you a code',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gaps.v20,
              normalText('Enter it below to verity'),
              normalText('${widget.email}.'),
              Gaps.v40,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerificationCode(
                    length: 6,
                    itemSize: 45,
                    cursorColor: Colors.transparent,
                    underlineWidth: 2,
                    underlineColor: Theme.of(context).primaryColor,
                    underlineUnfocusedColor: Colors.grey.shade400,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size28,
                    ),
                    onCompleted: (String value) {
                      setState(() {
                        _code = value;
                        _checkCode(value);
                      });
                    },
                    onEditing: (bool value) {
                      setState(() {
                        _onEditing = value;
                        _isCodeValid = false;
                      });
                      if (!_onEditing) FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _isCodeValid ? 1 : 0,
                    duration: Duration(milliseconds: 300),
                    child: FaIcon(
                      FontAwesomeIcons.solidCircleCheck,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    linkText(context, 'Didn\'t receive email?'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNext(
        _onNextTap,
        disable: !_isCodeValid,
      ),
    );
  }
}
