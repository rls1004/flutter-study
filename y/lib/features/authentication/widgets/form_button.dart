import 'package:flutter/material.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedContainer(
          width: Sizes.size72,
          height: Sizes.size40,
          decoration: BoxDecoration(
            color: disabled ? Colors.grey.shade600 : Colors.black,
            borderRadius: BorderRadius.circular(45),
          ),
          duration: Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 300),
                style: TextStyle(
                  color: disabled ? Colors.grey.shade400 : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size16,
                ),
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
