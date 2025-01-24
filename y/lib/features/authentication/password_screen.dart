import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';
import 'package:y/features/authentication/interests_screen.dart';
import 'package:y/features/authentication/utils/utils.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InterestsScreen(),
      ),
    );
  }

  void _onChange(String value) {
    setState(() {
      _password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: commonAppBar(canPop: false),
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
                  'You\'ll need a password',
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Gaps.v16,
                normalText('Make sure it\'s 8 characters or more.'),
                Gaps.v40,
                TextField(
                  readOnly: false,
                  showCursor: true,
                  controller: _passwordController,
                  obscureText: _obscureText,
                  // onTap: onTap,
                  onChanged: _onChange,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.grey,
                          ),
                        ),
                        Gaps.h10,
                        _isPasswordValid()
                            ? FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.teal,
                              )
                            : Gaps.v1,
                      ],
                    ),
                    hintText: 'Password',
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    // errorText: errorText,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNext(
          _onNextTap,
          disable: !_isPasswordValid(),
        ),
      ),
    );
  }
}
