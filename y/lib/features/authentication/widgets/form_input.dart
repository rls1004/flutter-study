import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/gaps.dart';

class FormInput extends StatefulWidget {
  bool disabled;
  bool password;
  FormInput({super.key, this.disabled, this.password});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
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
