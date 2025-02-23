import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

void showFirebaseErrorSnack(
  BuildContext context,
  Object? error,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
          (error as FirebaseException).message ?? "Something wen't to wrong."),
    ),
  );
}
