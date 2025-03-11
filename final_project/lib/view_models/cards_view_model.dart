import 'dart:async';

import 'package:final_project/data/models/card_model.dart';
import 'package:final_project/data/repos/authentication_repo.dart';
import 'package:final_project/data/repos/card_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CardsViewModel extends AsyncNotifier<List<CardModel>> {
  late final CardRepository _repository;
  List<CardModel> _list = [];
  bool isInitialized = false;

  @override
  FutureOr<List<CardModel>> build() async {
    if (!isInitialized) {
      _repository = ref.read(cardRepo);
    }

    isInitialized = true;

    ref.listen(authState, (_, __) {
      ref.invalidateSelf();
    });

    final user = ref.read(authRepo).user;
    final result = await _repository.fetchCards(user!.uid);

    final newList = result.docs.map((doc) {
      CardModel post = CardModel.fromJson(doc.data(), doc.id);
      return post;
    });
    _list = newList.toList();
    return _list;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authRepo).user;
      final result = await _repository.fetchCards(user!.uid);
      final newList = result.docs.map((doc) {
        CardModel post = CardModel.fromJson(doc.data(), doc.id);
        return post;
      });
      _list = newList.toList();
      state = AsyncData(_list);
    } catch (e) {}
  }

  Map<int, List<CardModel>> bundleByTime(List<CardModel> filteredList) {
    Map<int, List<CardModel>> cardsByTime = {};
    filteredList.sort((a, b) => a.recordTime.compareTo(b.recordTime));

    for (var card in filteredList) {
      if (!cardsByTime.keys.contains(card.recordTime)) {
        cardsByTime.addAll({card.recordTime: []});
      }

      cardsByTime[card.recordTime]!.add(card);

      // cardsByTime[card.recordTime]!.sort(
      //   (a, b) => a.createdAt.compareTo(b.createdAt),
      // );
    }

    return cardsByTime;
  }

  Map<int, List<CardModel>> searchByDay(DateTime selectedDay) {
    List<CardModel> filteredList =
        _list
            .where(
              (card) => isSameDay(
                DateTime.fromMillisecondsSinceEpoch(card.createdAt),
                selectedDay,
              ),
            )
            .toList();
    return bundleByTime(filteredList);
  }
}

final cardsProvider = AsyncNotifierProvider<CardsViewModel, List<CardModel>>(
  () => CardsViewModel(),
);
