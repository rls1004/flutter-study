import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Sizes.size5,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: Sizes.size40,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: Sizes.size1,
          ),
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Gaps.h10,
            Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: -0.5,
                  fontSize: Sizes.size20 - 2,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ),
      ),
    );
  }
}
