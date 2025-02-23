import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/features/auth/signup/view_models/signup_view_model.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup";

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _errorText = "";
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _email = _emailController.text;
      _isEmailValid();
      setState(() {});
    });
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isEmailValid() {
    bool isValid = false;
    if (_email.isEmpty) {
      _errorText = "";
      isValid = false;
    } else {
      final regExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (regExp.hasMatch(_email)) {
        isValid = true;
        _errorText = "";
      } else {
        _errorText = "Invalid email";
      }
    }
    setState(() {});
    return isValid;
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
    if (!_isEmailValid()) return false;
    bool isValid = _password.isNotEmpty && _password.length >= 8;
    if (_password.isNotEmpty && !isValid) {
      _errorText = "8 <= pasword length";
    } else {
      _errorText = "";
    }
    setState(() {});
    return isValid;
  }

  bool _isConfirmPasswordValid() {
    bool isValid = _isPasswordValid() && (_password == _confirmPassword);
    if (_isPasswordValid() && _confirmPassword.isNotEmpty && !isValid) {
      _errorText = "password not equal";
    } else if (_isPasswordValid()) {
      _errorText = "";
    }
    setState(() {});
    return isValid;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onTapSignUp() {
    if (ref.read(signUpProvider).isLoading) return;

    ref.read(signUpForm.notifier).state = {
      "email": _email,
      "password": _password,
    };

    ref.read(signUpProvider.notifier).signUp(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Sizes.size80 + Sizes.size80,
          title: Column(
            children: [
              Gaps.v40,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: FaIcon(
                    FontAwesomeIcons.threads,
                    size: Sizes.size72,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Text(
                    _errorText,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.red,
                    ),
                  ),
                ),
                Gaps.v20,
                TextField(
                  readOnly: false,
                  showCursor: true,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _isEmailValid()
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
                Gaps.v16,
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
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
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
                Gaps.v16,
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
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                    ),
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
                Gaps.v16,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _onTapSignUp,
                        child: Container(
                          height: Sizes.size56,
                          decoration: BoxDecoration(
                            color: ref.watch(signUpProvider).isLoading
                                ? Colors.grey
                                : Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: Sizes.size16 + Sizes.size2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
          height: Sizes.size80 + Sizes.size32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.meta,
                    size: Sizes.size20,
                  ),
                  Gaps.h4,
                  Text(
                    "Meta",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
