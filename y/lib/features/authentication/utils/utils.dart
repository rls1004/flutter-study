import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/sizes.dart';

AppBar commonAppBar({bool canPop = true}) {
  return AppBar(
    automaticallyImplyLeading: canPop,
    title: FaIcon(
      FontAwesomeIcons.twitter,
      size: 30,
      color: Colors.blue,
    ),
  );
}

Text linkText(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: Sizes.size14,
      color: Theme.of(context).primaryColor,
      letterSpacing: -0.1,
    ),
  );
}

Text normalText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: Sizes.size14,
      color: Colors.black54,
      letterSpacing: -0.1,
    ),
  );
}

BottomAppBar bottomNext(GestureTapCallback onNextTap,
    {bool disable = false, String text = 'Next'}) {
  return BottomAppBar(
    child: GestureDetector(
      onTap: disable ? () {} : onNextTap,
      child: Container(
        width: 200,
        height: 70,
        decoration: BoxDecoration(
          color: disable ? Colors.grey.shade600 : Colors.black,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyle(
                color: disable ? Colors.grey.shade400 : Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: Sizes.size20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
