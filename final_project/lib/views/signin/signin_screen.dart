import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninScreen extends ConsumerStatefulWidget {
  static const routeName = "/signin";

  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
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
      _isEmailValid();
      setState(() {});
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
      setState(() {});
    });
  }

  bool _isEmailValid() {
    bool isValid = false;
    if (_email.isEmpty) {
      isValid = false;
    } else {
      final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      );
      if (regExp.hasMatch(_email)) {
        isValid = true;
      } else {}
    }
    setState(() {});
    return isValid;
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onTapSignin() {
    if (ref.read(signinProvider).isLoading) return;
    ref.read(signinProvider.notifier).login(_email, _password, context);
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
                "계정 정보를 입력하세요",
                style: Theme.of(context).textTheme.headlineLarge,
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
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isEmailValid()
                          ? FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Colors.teal,
                          )
                          : FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Colors.grey,
                          ),
                    ],
                  ),
                ),
                style: TextStyle(
                  fontSize: Sizes.size16 + Sizes.size2,
                  height: 1.8,
                ),
              ),

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
                    ],
                  ),
                ),
                style: TextStyle(
                  fontSize: Sizes.size16 + Sizes.size2,
                  height: 1.8,
                ),
              ),

              Expanded(child: Container()),

              Center(
                child: ElevatedButton(
                  onPressed: _onTapSignin,
                  style: ButtonStyle(
                    shape: WidgetStateOutlinedBorder.fromMap({
                      WidgetState.any: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    }),
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                    backgroundColor: WidgetStateColor.resolveWith(
                      (state) =>
                          (_email.isNotEmpty && _password.isNotEmpty)
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
                          "로그인",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(
                              (_email.isNotEmpty && _password.isNotEmpty)
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
