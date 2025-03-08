import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/data/models/card_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveCard(CardModel data) async {
    await _db.collection("cards").add(data.toJson());
  }

  Future<void> deleteCard(String postID) async {
    await _db.collection("cards").doc(postID).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchCards(String uid) {
    return _db
        .collection("cards")
        .where("creatorUid", isEqualTo: uid)
        .orderBy("createdAt", descending: false)
        .get();
  }
}

final cardRepo = Provider((ref) => CardRepository());
