import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/data/models/card_model.dart';
import 'package:final_project/data/repos/authentication_repo.dart';
import 'package:final_project/data/repos/card_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AnalysisViewModel extends AsyncNotifier<Map<String, List<CardModel>>> {
  late final CardRepository _repository;
  Map<String, List<CardModel>> _listByWeek = {'this': [], 'last': []};
  DateTime now = DateTime.now();
  late QuerySnapshot<Map<String, dynamic>> result;
  bool isInitialized = false;

  @override
  FutureOr<Map<String, List<CardModel>>> build() async {
    if (!isInitialized) {
      _repository = ref.read(cardRepo);
    }

    isInitialized = true;

    ref.listen(authState, (_, __) {
      ref.invalidateSelf();
    });

    final user = ref.read(authRepo).user;
    result = await _repository.fetchCards(user!.uid);

    final newList = result.docs.map((doc) {
      CardModel post = CardModel.fromJson(doc.data(), doc.id);
      return post;
    });

    Map<String, List<CardModel>> newData = {'this': [], 'last': []};

    for (var card in newList) {
      bool isThisWeek = _isBelong(
        now,
        DateTime.fromMillisecondsSinceEpoch(card.createdAt),
      );
      bool isLastWeek = _isBelong(
        now.subtract(Duration(days: 7)),
        DateTime.fromMillisecondsSinceEpoch(card.createdAt),
      );

      if (isThisWeek) {
        newData['this']!.add(card);
      } else if (isLastWeek) {
        newData['last']!.add(card);
      }
    }

    _listByWeek = newData;
    return _listByWeek;
  }

  bool _isBelong(DateTime x, DateTime y) {
    DateTime startOfWeek = x.subtract(Duration(days: x.weekday - 1));
    DateTime endOfWeek = x.add(Duration(days: 7 - x.weekday));

    startOfWeek = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
      0,
      0,
      0,
      0,
      0,
    );
    endOfWeek = DateTime(
      endOfWeek.year,
      endOfWeek.month,
      endOfWeek.day,
      0,
      0,
      0,
      0,
      0,
    ).add(Duration(days: 1));

    if (y.isAfter(startOfWeek) && y.isBefore(endOfWeek)) return true;

    return false;
  }

  double getCountByDay(int weekday) {
    double count = 0;
    for (var card in _listByWeek['this']!) {
      if (DateTime.fromMillisecondsSinceEpoch(card.createdAt).weekday ==
          weekday) {
        count += 1;
      }
    }
    return count;
  }

  List<double> getCountByEmojiThisWeek() {
    List<double> count = [0, 0, 0, 0, 0];
    for (var card in _listByWeek['this']!) {
      count[card.emoji] += 1;
    }
    return count;
  }

  List<double> getCountByEmojiLastWeek() {
    List<double> count = [0, 0, 0, 0, 0];
    for (var card in _listByWeek['last']!) {
      count[card.emoji] += 1;
    }
    return count;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final user = ref.read(authRepo).user;
      result = await _repository.fetchCards(user!.uid);
      final newList = result.docs.map((doc) {
        CardModel post = CardModel.fromJson(doc.data(), doc.id);
        return post;
      });

      Map<String, List<CardModel>> newData = {'this': [], 'last': []};

      for (var card in newList) {
        bool isThisWeek = _isBelong(
          now,
          DateTime.fromMillisecondsSinceEpoch(card.createdAt),
        );
        bool isLastWeek = _isBelong(
          now.subtract(Duration(days: 7)),
          DateTime.fromMillisecondsSinceEpoch(card.createdAt),
        );

        if (isThisWeek) {
          newData['this']!.add(card);
        } else if (isLastWeek) {
          newData['last']!.add(card);
        }
      }

      _listByWeek = newData;
      state = AsyncData(_listByWeek);
    } catch (e) {}
  }

  void changeBaseWeek({required back}) {
    if (back) {
      now = now.subtract(Duration(days: 7));
    } else {
      now = now.add(Duration(days: 7));
    }

    refresh();
  }

  void initWeek() {
    now = DateTime.now();
    refresh();
  }

  Future<List<int>> fetchSummaryStats() async {
    if (state.value == null) {
      await future;
    }

    int highestRecord = 0;

    final newList = result.docs.map((doc) {
      CardModel post = CardModel.fromJson(doc.data(), doc.id);
      return post;
    });

    String prevDay = "";
    int currentCount = 0;
    List<int> emojiTotal = [0, 0, 0, 0, 0];

    for (var card in newList) {
      DateTime cardDate = DateTime.fromMillisecondsSinceEpoch(card.createdAt);
      String df = DateFormat.yMd().format(cardDate);

      emojiTotal[card.emoji] += 1;

      if (df == prevDay) {
        currentCount += 1;
      } else {
        prevDay = df;
        highestRecord = max(highestRecord, currentCount);
        currentCount = 1;
      }
    }

    highestRecord = max(highestRecord, currentCount);

    int maxValue = emojiTotal.reduce((curr, next) => curr > next ? curr : next);

    int mostEmoji = emojiTotal.indexOf(maxValue);

    return [result.size, highestRecord, mostEmoji, maxValue];
  }
}

final analysisProvider =
    AsyncNotifierProvider<AnalysisViewModel, Map<String, List<CardModel>>>(
      () => AnalysisViewModel(),
    );
