import 'dart:async';
import 'dart:io';

import 'package:final_project/data/models/card_model.dart';
import 'package:final_project/data/repos/authentication_repo.dart';
import 'package:final_project/data/repos/card_repo.dart';
import 'package:final_project/view_models/analysis_view_model.dart';
import 'package:final_project/view_models/cards_view_model.dart';
import 'package:final_project/view_models/users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WriteCardViewModel extends AsyncNotifier<void> {
  late final CardRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(cardRepo);
  }

  Future<void> uploadCard(
    BuildContext context, {
    File? image,
    required String contents,
    required int emoji,
    required int recordTime,
  }) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;

    if (userProfile != null) {
      state = AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        await _repository.saveCard(
          CardModel(
            contents: contents,
            creatorUid: user!.uid,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            recordTime: recordTime,
            creator: userProfile.username,
            emoji: emoji,
          ),
        );
        if (!context.mounted) return;

        ref.read(cardsProvider.notifier).refresh();
        ref.read(analysisProvider.notifier).refresh();
        context.pop();
      });
    }
  }

  void deleteCard(BuildContext context, {required String postID}) {
    // final user = ref.read(authRepo).user;
    _repository.deleteCard(postID);
  }
}

final writeCardProvider = AsyncNotifierProvider<WriteCardViewModel, void>(
  () => WriteCardViewModel(),
);
