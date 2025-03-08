import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/signup_view_model.dart';
import 'package:final_project/views/signup/signup_survey_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SignupDateScreen extends ConsumerStatefulWidget {
  static const routeName = "/signup/date";

  const SignupDateScreen({super.key});

  @override
  ConsumerState<SignupDateScreen> createState() => _SignupDateScreenState();
}

class _SignupDateScreenState extends ConsumerState<SignupDateScreen> {
  final TextEditingController dateController = TextEditingController();
  bool _isTapedDate = false;
  String _dateOfBirth = "";

  DateTime initialDate = DateTime.now();

  onTapDate() {
    _isTapedDate = true;
    setState(() {});
  }

  void _setTextFiledDate(DateTime date) {
    String formattedDate = DateFormat('M / d / y').format(date);
    dateController.value = TextEditingValue(text: formattedDate);
    _dateOfBirth = formattedDate;

    setState(() {});
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
    _isTapedDate = false;
    setState(() {});
  }

  void _onTapNext() {
    if (_dateOfBirth.isEmpty) return;

    if (ref.read(signUpProvider).isLoading) return;

    var form = ref.read(signUpForm);
    form.addAll({'birth': _dateOfBirth});
    ref.read(signUpForm.notifier).state = form;
    context.push(SignupSurveyScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    initialDate = DateTime(
      initialDate.year - 12,
      initialDate.month,
      initialDate.day,
    );
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
                "생일을 알려주세요.",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gaps.v20,
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    textAlign: TextAlign.center,
                    readOnly: true,
                    showCursor: true,
                    controller: dateController,
                    onTap: onTapDate,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      hintText: "M / D / Y",
                      // labelText: label,
                      // errorText: errorText,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                    style: TextStyle(
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                          _dateOfBirth.isEmpty
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
                              _dateOfBirth.isNotEmpty ? 1 : 0.6,
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

        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: _isTapedDate ? 300 : 0,
          child:
              _isTapedDate
                  ? BottomAppBar(
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      initialDateTime: initialDate,
                      maximumDate: initialDate,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: _setTextFiledDate,
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}
