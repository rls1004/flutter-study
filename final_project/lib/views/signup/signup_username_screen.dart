import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupUsernameScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup/username";

  const SignupUsernameScreen({super.key});

  @override
  ConsumerState<SignupUsernameScreen> createState() =>
      _SignupUsernameScreenState();
}

class _SignupUsernameScreenState extends ConsumerState<SignupUsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  String _username = "";

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      _username = _usernameController.text;
      setState(() {});
    });
  }

  void _onTapNext() {
    if (ref.read(signUpProvider).isLoading) return;

    var form = ref.read(signUpForm);
    form.addAll({'username': _username});
    ref.read(signUpForm.notifier).state = form;

    ref.read(signUpProvider.notifier).signUp(context);
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
                "마지막 이에요!\n뭐라고 불러드릴까요?",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gaps.v20,

              TextField(
                textAlign: TextAlign.center,
                readOnly: false,
                showCursor: true,
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "닉네임",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: Sizes.size32, height: 1.8),
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
                          _username.isEmpty
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
                              _username.isEmpty ? 0.6 : 1,
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
