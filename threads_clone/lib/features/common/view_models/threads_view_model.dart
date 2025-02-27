import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/features/write/models/post_model.dart';
import 'package:threads_clone/features/common/repos/post_repo.dart';

class ThreadsViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _repository;
  List<PostModel> _list = [];
  @override
  FutureOr<List<PostModel>> build() async {
    _repository = ref.read(postRepo);
    final result = await _repository.fetchPosts();

    final newList = await Future.wait(
      result.docs.map(
        (doc) async {
          PostModel post = PostModel.fromJson(
            doc.data(),
            doc.id,
          );

          List<String> fileList = await fetchAttachments(doc.id);
          post.setAttachment(fileList);

          return post;
        },
      ),
    );
    _list = newList.toList();
    return _list;
  }

  Future<List<String>> fetchAttachments(String postId) async {
    final result = await _repository.fetchAttachments(postId);
    final newList = result.docs.map(
      (doc) => doc.data()["fileUrl"] as String,
    );
    List<String> fileUrls = [];
    fileUrls = newList.toList();
    return fileUrls;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final result = await _repository.fetchPosts();
      final newList = await Future.wait(
        result.docs.map(
          (doc) async {
            PostModel post = PostModel.fromJson(
              doc.data(),
              doc.id,
            );

            List<String> fileList = await fetchAttachments(doc.id);
            post.setAttachment(fileList);

            return post;
          },
        ),
      );
      state = AsyncData(newList);
    } catch (e) {}
  }

  List<PostModel> search(String search, {bool popular = false}) {
    final filteredList = _list
        .where((post) =>
            post.description.toLowerCase().contains(search.toLowerCase()))
        .toList();

    if (popular) {
      filteredList.sort((a, b) => b.likes.compareTo(a.likes));
    }

    return filteredList;
  }
}

final threadsProvider =
    AsyncNotifierProvider<ThreadsViewModel, List<PostModel>>(
  () => ThreadsViewModel(),
);
