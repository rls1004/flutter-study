import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/features/common/view_models/threads_view_model.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/features/home/views/widgets/post_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ref.watch(threadsProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load threads: $error',
            ),
          ),
          data: (data) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: FaIcon(
                      FontAwesomeIcons.threads,
                      size: Sizes.size40,
                    ),
                  ),
                  SliverList.list(
                    children: data
                        .map((post) => PostCardWidget(postData: post))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
