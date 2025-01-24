import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';
import 'package:y/features/authentication/auth_screen.dart';
import 'package:y/features/authentication/setting_screen.dart';
import 'package:y/features/authentication/widgets/common_widget.dart';
import 'package:y/features/authentication/widgets/form_button.dart';

class SignUpScreen extends StatefulWidget {
  final bool? settingAgree;
  final String? name;
  final String? email;
  final String? dateOfBirth;
  const SignUpScreen(
      {super.key, this.settingAgree, this.name, this.email, this.dateOfBirth});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birtdayController = TextEditingController();

  String _name = "";
  String _emailOrPhone = "";
  String _dateOfBirth = "";
  DateTime initialDate = DateTime.now();
  bool _isTapedDate = false;
  bool _isTapedEmail = false;

  bool _isNameValid = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
        if (_name.isEmpty) {
          _isNameValid = false;
        } else {
          _isNameValid = true;
        }
      });
    });

    _emailController.addListener(() {
      setState(() {
        _emailOrPhone = _emailController.text;
      });
    });

    initialDate =
        DateTime(initialDate.year - 12, initialDate.month, initialDate.day);

    if (widget.settingAgree != null) {
      _nameController.value = TextEditingValue(text: widget.name!);
      _emailController.value = TextEditingValue(text: widget.email!);
      _birtdayController.value = TextEditingValue(text: widget.dateOfBirth!);

      _name = widget.name!;
      _emailOrPhone = widget.email!;
      _dateOfBirth = widget.dateOfBirth!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onEmailTap() {
    _isTapedEmail = true;
  }

  String? _checkEmailValid() {
    if (_emailOrPhone.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (regExp.hasMatch(_emailOrPhone)) {
      _isEmailValid = true;
      return null;
    }
    _isEmailValid = false;
    return "Not Valid";
  }

  void _onNextTap() {
    if (!_isNameValid || !_isEmailValid || _dateOfBirth.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingScreen(
            name: _name, email: _emailOrPhone, dateOfBirth: _dateOfBirth),
      ),
    );
  }

  void _onSignUpTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AuthScreen(
          name: widget.name,
          email: widget.email,
          dateOfBirth: widget.dateOfBirth,
          settingAgree: widget.settingAgree,
        ),
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
    _isTapedDate = false;
    if (_emailOrPhone.isEmpty) _isTapedEmail = false;
  }

  void _setTextFiledDate(DateTime date) {
    String formattedDate = DateFormat('MMMM d, y').format(date);
    _birtdayController.value = TextEditingValue(text: formattedDate);
    _dateOfBirth = formattedDate;
  }

  void _showDatePicker() {
    setState(() {
      _isTapedDate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
                  'Create your account',
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Gaps.v20,
                makeTextField(context, 'Name', 'Name', _nameController,
                    validCheck: _isNameValid),
                Gaps.v20,
                makeTextField(
                  context,
                  'Phone number or email address',
                  _isTapedEmail ? 'Email' : 'Phone number or email address',
                  _emailController,
                  errorText: _checkEmailValid(),
                  onTap: _onEmailTap,
                  validCheck: _isEmailValid,
                ),
                Gaps.v20,
                makeTextField(
                  context,
                  'Date of birth',
                  'Date of birth',
                  _birtdayController,
                  onTap: _showDatePicker,
                  validCheck: _dateOfBirth.isNotEmpty,
                  isDateField: true,
                ),
                Gaps.v10,
                (widget.settingAgree != null || !_isTapedDate)
                    ? Gaps.v1
                    : Text(
                        'This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                widget.settingAgree != null
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Wrap(
                              children: [
                                normalText('By signing up, you agree to the '),
                                linkText(context, 'Term of Service'),
                                normalText('and '),
                                linkText(context, 'Privacy Policy'),
                                normalText(', including '),
                                linkText(context, 'Cookie Use'),
                                normalText('.'),
                                normalText(
                                    'Twitter use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing'),
                                normalText(' our services, including ads. '),
                                linkText(context, 'Learn more'),
                                normalText('.'),
                                normalText(
                                    'Others will be able to find you by email or phone number, when provided, unless you'),
                                normalText('shoose otherwise '),
                                linkText(context, 'here'),
                                normalText('.'),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: Sizes.size40,
                          ),
                          child: GestureDetector(
                            onTap: _onNextTap,
                            child: FormButton(
                                disabled: !_isNameValid ||
                                    !_isEmailValid ||
                                    _dateOfBirth.isEmpty),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.settingAgree != null
            ? BottomAppBar(
                elevation: 0,
                color: Colors.white,
                child: GestureDetector(
                  onTap: _onSignUpTap,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: _isTapedDate ? 300 : 0,
                child: _isTapedDate
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

  Widget makeTextField(
    BuildContext context,
    String hint,
    String label,
    TextEditingController ctrl, {
    String? errorText,
    GestureTapCallback? onTap,
    bool validCheck = false,
    bool isDateField = false,
  }) {
    return Stack(
      children: [
        TextField(
          readOnly: isDateField || widget.settingAgree != null ? true : false,
          showCursor: widget.settingAgree != null ? false : true,
          controller: ctrl,
          onTap: onTap,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            errorText: errorText,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Gaps.v20,
                AnimatedOpacity(
                  opacity: validCheck ? 1 : 0,
                  duration: Duration(milliseconds: 300),
                  child: FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            Gaps.h8,
          ],
        ),
      ],
    );
  }
}
