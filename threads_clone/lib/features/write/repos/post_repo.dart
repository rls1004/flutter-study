import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/features/write/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload
  UploadTask uploadImageFile(File image, String uid) {
    final fileRef = _storage.ref().child(
          "/images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}",
        );

    return fileRef.putFile(image);
  }

  // create a document
  Future<void> savePost(PostModel data, String fileUrl) async {
    final docRef = await _db.collection("posts").add(data.toJson());
    if (data.hasAttachments) {
      docRef.id;
      PostImageModel postImageData = PostImageModel(
        postId: docRef.id,
        number: 0,
        fileUrl: fileUrl,
        creatorUid: data.creatorUid,
        createdAt: data.createdAt,
        creator: data.creator,
      );
      await _db
          .collection("posts")
          .doc(docRef.id)
          .collection("attachments")
          .add(postImageData.toJson());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts() {
    return _db.collection("posts").orderBy("createdAt", descending: true).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchAttachments(String postId) {
    return _db
        .collection("posts")
        .doc(postId)
        .collection("attachments")
        .orderBy("number", descending: true)
        .get();
  }
}

final postRepo = Provider((ref) => PostRepository());
