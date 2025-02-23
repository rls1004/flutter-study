import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/auth/repos/authentication_repo.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/features/profiles/views/settings/setting_screen.dart';
import 'package:threads_clone/features/home/views/widgets/post_card_widget.dart';
import 'package:threads_clone/features/home/views/widgets/profile_widget.dart';
import 'package:threads_clone/features/home/views/widgets/replies_image_widget.dart';
import 'package:threads_clone/features/profiles/views/widgets/reply_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/utils/utils.dart';

class ProfileScreen extends ConsumerWidget {
  static const routeName = "/profile";

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String userName = ref.read(authRepo).user?.email?.split('@')[0] ?? "";
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              ProfileAppBar(
                userName: userName,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyHeaderDelegate(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    alignment: Alignment.center,
                    child: TabBar(
                      dividerColor: Colors.grey,
                      indicatorColor:
                          isDarkMode(context) ? Colors.white : Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor:
                          isDarkMode(context) ? Colors.white : Colors.black,
                      unselectedLabelColor: isDarkMode(context)
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.5),
                      tabs: [
                        Tab(
                          child: Text("Threads"),
                        ),
                        Tab(
                          child: Text("Replies"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: [
                CustomScrollView(
                  slivers: [SliverList.list(children: getThreads(userName))],
                ),
                CustomScrollView(
                  slivers: [SliverList.list(children: getReplies(userName))],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  final String userName;
  const ProfileAppBar({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 220,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.language,
                  size: 30,
                ),
                Spacer(),
                FaIcon(FontAwesomeIcons.instagram, size: 30),
                Gaps.h14,
                GestureDetector(
                  onTap: () => context.push(SettingScreen.routeName),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 30,
                    height: 25,
                    decoration: BoxDecoration(),
                    child: Icon(
                      Icons.segment,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            Gaps.v20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: TextStyle(
                          fontSize: Sizes.size24,
                          fontWeight: FontWeight.w600,
                        )),
                    Row(
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: Sizes.size16,
                          ),
                        ),
                        Gaps.h10,
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            width: 83,
                            height: 20,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            child: Center(
                              child: Text(
                                "threads.net",
                                style: TextStyle(
                                  fontSize: Sizes.size14,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Plant enthusiast!",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ProfileWidget(
                  profileUrl: getUrl(width: 100, seed: userName),
                  radius: 30,
                ),
              ],
            ),
            Row(
              children: [
                RepliesImageWidget(num: 2),
                Gaps.h5,
                Opacity(
                  opacity: 0.3,
                  child: Text(
                    "2 followers",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 160,
                  height: 35,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Edit profile",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 160,
                  height: 35,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Share profile",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;
  @override
  double get minExtent => 50;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
