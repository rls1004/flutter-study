import 'dart:async';

import 'package:final_project/data/repos/authentication_repo.dart';
import 'package:final_project/utils/utils.dart';
import 'package:final_project/view_models/users_view_model.dart';
import 'package:final_project/views/signup/signup_finish_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();

    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);

    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );
      await users.createProfile(
        userCredential,
        username: form["username"],
        gender: form["gender"],
        birth: form["birth"],
        goal: form["goal"],
      );
    });

    if (state.hasError) {
      if (!context.mounted) return;
      showFirebaseErrorSnack(context, state.error);
    } else {
      if (!context.mounted) return;
      context.go(SignupFinishScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
