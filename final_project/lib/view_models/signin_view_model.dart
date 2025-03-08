import 'dart:async';

import 'package:final_project/data/repos/authentication_repo.dart';
import 'package:final_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email, password),
    );

    if (state.hasError) {
      if (!context.mounted) return;
      showFirebaseErrorSnack(context, state.error);
    }
  }
}

final signinProvider = AsyncNotifierProvider<SigninViewModel, void>(
  () => SigninViewModel(),
);
