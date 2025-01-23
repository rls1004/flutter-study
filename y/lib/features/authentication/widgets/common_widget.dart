import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:y/constants/sizes.dart';

AppBar commonAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
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
