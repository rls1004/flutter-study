import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/features/auth/repos/authentication_repo.dart';
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
    state = await AsyncValue.guard(
      () async => await _authRepo.signUp(
        form["email"],
        form["password"],
      ),
    );

    if (state.hasError) {
      if (state.hasError) {
        showFirebaseErrorSnack(context, state.error);
      }
    }
  }
}

final signUpForm = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
