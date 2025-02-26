import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/auth/repos/authentication_repo.dart';
import 'package:threads_clone/features/home/views/home_screen.dart';
import 'package:threads_clone/features/profiles/view_models/users_view_model.dart';
import 'package:threads_clone/features/write/models/post_model.dart';
import 'package:threads_clone/features/write/repos/post_repo.dart';
import 'package:threads_clone/features/write/view_models/threads_view_model.dart';

class UploadPostViewModel extends AsyncNotifier<void> {
  late final PostRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(postRepo);
  }

  Future<void> uploadPost(BuildContext context,
      {File? image, required String description}) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    String fileUrl = "";

    if (userProfile != null) {
      state = AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        if (image != null) {
          final task = await _repository.uploadImageFile(image, user!.uid);
          if (task.metadata != null) {
            fileUrl = await task.ref.getDownloadURL();
          }
        }

        print(userProfile.name);

        await _repository.savePost(
          PostModel(
            description: description,
            creatorUid: user!.uid,
            likes: 0,
            comments: 0,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            creator: userProfile.name,
            hasAttachments: fileUrl.isNotEmpty ? true : false,
          ),
          fileUrl,
        );
        ref.read(threadsProvider.notifier).refresh();
        context.pop();
        context.go(HomeScreen.routeName);
      });
    }
  }
}

final uploadPostProvider = AsyncNotifierProvider<UploadPostViewModel, void>(
    () => UploadPostViewModel());
