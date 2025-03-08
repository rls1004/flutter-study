import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/signup_view_model.dart';
import 'package:final_project/views/signup/signup_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignupEmailScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup/email";

  const SignupEmailScreen({super.key});

  @override
  ConsumerState<SignupEmailScreen> createState() => _SignupEmailScreenState();
}

class _SignupEmailScreenState extends ConsumerState<SignupEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";
  String _errorText = "";

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _email = _emailController.text;
      _isEmailValid();
      setState(() {});
    });
  }

  bool _isEmailValid() {
    bool isValid = false;
    if (_email.isEmpty) {
      _errorText = "이메일을 입력해주세요";
      isValid = false;
    } else {
      final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      );
      if (regExp.hasMatch(_email)) {
        isValid = true;
        _errorText = "";
      } else {
        _errorText = "잘못된 형식입니다";
      }
    }
    setState(() {});
    return isValid;
  }

  void _onTapNext() {
    if (!_isEmailValid()) return;

    if (ref.read(signUpProvider).isLoading) return;

    var form = ref.read(signUpForm);
    form.addAll({'email': _email});
    ref.read(signUpForm.notifier).state = form;

    context.push(SignupPasswordScreen.routeName);
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
                "반가요워!\n가입할 이메일을 알려주세요",
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
                          _errorText.isNotEmpty
                              ? Colors.blue.shade200
                              : Colors.blue.shade400,
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
                              _errorText.isNotEmpty ? 0.6 : 1,
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
