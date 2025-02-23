import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/auth/login/view_models/login_view_model.dart';
import 'package:threads_clone/features/auth/signup/views/signup_screen.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _email = _emailController.text;
      setState(() {});
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onLoginTap() {
    if (ref.read(loginProvider).isLoading) return;
    ref.read(loginProvider.notifier).login(_email, _password, context);
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
                Gaps.v36,
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Mobile number or email",
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
                        onTap: _onLoginTap,
                        child: Container(
                          height: Sizes.size56,
                          decoration: BoxDecoration(
                            color: ref.read(loginProvider).isLoading
                                ? Colors.grey
                                : Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "Log in",
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
                Gaps.v20,
                Center(
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
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
              GestureDetector(
                onTap: () => context.push(SignUpScreen.routeName),
                child: Container(
                  height: Sizes.size40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Create new account",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.v10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.meta,
                    size: Sizes.size20,
                    color: Colors.grey,
                  ),
                  Gaps.h4,
                  Text(
                    "Meta",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
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
