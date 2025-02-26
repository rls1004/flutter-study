import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/features/auth/repos/authentication_repo.dart';
import 'package:threads_clone/features/profiles/models/user_profile_model.dart';
import 'package:threads_clone/features/profiles/repos/user_repo.dart';

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
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = AsyncValue.loading();

    final String displayName = credential.user!.email?.split('@')[0] ?? "Anon";

    final profile = UserProfileModel(
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "anon@anoan.com",
      uid: credential.user!.uid,
      name: displayName,
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
    () => UsersViewModel());
