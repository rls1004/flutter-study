import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/auth/repos/authentication_repo.dart';
import 'package:threads_clone/features/home/views/home_screen.dart';
import 'package:threads_clone/features/profiles/view_models/users_view_model.dart';
import 'package:threads_clone/utils/utils.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUp(
        form["email"],
        form["password"],
      );
      await users.createProfile(userCredential);
    });

    if (state.hasError) {
      if (state.hasError) {
        showFirebaseErrorSnack(context, state.error);
      }
    } else {
      // another first screen for new users
    }
  }
}

final signUpForm = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
