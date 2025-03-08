import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/signup_view_model.dart';
import 'package:final_project/views/signup/signup_gender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignupPasswordScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup/password";

  const SignupPasswordScreen({super.key});

  @override
  ConsumerState<SignupPasswordScreen> createState() =>
      _SignupPasswordScreenState();
}

class _SignupPasswordScreenState extends ConsumerState<SignupPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _password = "";
  String _confirmPassword = "";
  String _errorText = "";
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      _password = _passwordController.text;
      _isPasswordValid();
      setState(() {});
    });
    _confirmPasswordController.addListener(() {
      _confirmPassword = _confirmPasswordController.text;
      _isConfirmPasswordValid();
      setState(() {});
    });
  }

  void _onTapNext() {
    if (!_isPasswordValid() || !_isConfirmPasswordValid()) return;

    if (ref.read(signUpProvider).isLoading) return;

    var form = ref.read(signUpForm);
    form.addAll({'password': _password});
    ref.read(signUpForm.notifier).state = form;
    context.push(SignupGenderScreen.routeName);
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleObscureConfirmPassword() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  bool _isPasswordValid() {
    bool isValid = _password.isNotEmpty && _password.length >= 8;
    if (_password.isNotEmpty && !isValid) {
      _errorText = "비밀번호는 8자 이상이어야 합니다";
    } else {
      _errorText = "";
    }
    setState(() {});
    return isValid;
  }

  bool _isConfirmPasswordValid() {
    bool isValid = _isPasswordValid() && (_password == _confirmPassword);
    if (_isPasswordValid() && _confirmPassword.isNotEmpty && !isValid) {
      _errorText = "비밀번호가 일치하지 않습니다";
    } else if (_isPasswordValid()) {
      _errorText = "";
    }
    setState(() {});
    return isValid;
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapScaffold,
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
                "비밀번호를 입력하세요",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gaps.v20,

              TextField(
                readOnly: false,
                showCursor: true,
                controller: _passwordController,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _toggleObscurePassword,
                        child: FaIcon(
                          _obscurePassword
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
                ),
                style: TextStyle(
                  fontSize: Sizes.size16 + Sizes.size2,
                  height: 1.8,
                ),
              ),
              Gaps.v10,
              TextField(
                readOnly: false,
                showCursor: true,
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Confirm your password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _toggleObscureConfirmPassword,
                        child: FaIcon(
                          _obscureConfirmPassword
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          color: Colors.grey,
                        ),
                      ),
                      Gaps.h10,
                      _isConfirmPasswordValid()
                          ? FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Colors.teal,
                          )
                          : Gaps.v1,
                    ],
                  ),
                ),
                style: TextStyle(
                  fontSize: Sizes.size16 + Sizes.size2,
                  height: 1.8,
                ),
              ),

              Center(
                child: Text(_errorText, style: TextStyle(color: Colors.red)),
              ),

              Expanded(child: Container()),

              Center(
                child: ElevatedButton(
                  onPressed: _onTapNext,
                  style: ButtonStyle(
                    shape: WidgetStateOutlinedBorder.fromMap({
                      WidgetState.any: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    }),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    backgroundColor: WidgetStateColor.resolveWith(
                      (state) =>
                          _errorText.isEmpty && _confirmPassword.isNotEmpty
                              ? Colors.blue.shade400
                              : Colors.blue.shade200,
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: Sizes.size60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "다음",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(
                              _errorText.isEmpty && _confirmPassword.isNotEmpty
                                  ? 1
                                  : 0.6,
                            ),
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
