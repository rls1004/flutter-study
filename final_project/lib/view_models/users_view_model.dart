import 'dart:async';

import 'package:final_project/data/models/user_profile_model.dart';
import 'package:final_project/data/repos/authentication_repo.dart';
import 'package:final_project/data/repos/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;
  bool isInitialized = false;

  @override
  FutureOr<UserProfileModel> build() async {
    if (!isInitialized) {
      _usersRepository = ref.read(userRepo);
      _authenticationRepository = ref.read(authRepo);
    }
    isInitialized = true;

    ref.listen(authState, (_, __) {
      ref.invalidateSelf();
    });

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository.findProfile(
        _authenticationRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> logout() async {
    await _authenticationRepository.signOut();
    state = AsyncValue.data(UserProfileModel.empty());
  }

  Future<void> createProfile(
    UserCredential credential, {
    required String username,
    required GENDER gender,
    required String birth,
    required GOAL goal,
  }) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = AsyncValue.loading();

    final profile = UserProfileModel(
      email: credential.user!.email!,
      uid: credential.user!.uid,
      username: username,
      gender: gender,
      birth: birth,
      goal: goal,
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
