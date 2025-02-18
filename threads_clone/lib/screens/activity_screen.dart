import 'package:flutter/material.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/models/activity_model.dart';
import 'package:threads_clone/screens/widgets/profile_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/utils/utils.dart';

class ActivityScreen extends StatefulWidget {
  static const routeName = "/activity";
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String selectedActivity = "All";
  List<ActionModel> activities = [];

  @override
  void initState() {
    super.initState();
    selectedActivity = "All";
    for (var i = 0; i < 10; i++) {
      activities.add(generateFakeActivity());
    }
    activities.sort((a, b) => a.time < b.time ? -1 : 1);
  }

  @override
  Widget build(BuildContext context) {
    void onTap(String value) {
      setState(() {
        selectedActivity = value;
      });
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                "Activity",
                style: TextStyle(
                  fontSize: Sizes.size32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
            ),
          ),
          bottom: ActivityTabBar(
            selectedActivity: selectedActivity,
            onTap: onTap,
          ),
        ),
        body: TabBarView(
          children: [
            for (var actType in [
              null,
              ActionType.reply,
              ActionType.mention,
              ActionType.follow,
              ActionType.like
            ])
              CustomScrollView(
                slivers: [
                  SliverList.list(
                    children: [
                      Gaps.v10,
                      for (var activity in activities)
                        if (actType == null || activity.act == actType)
                          ActivityTile(activity: activity),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ActivityTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Function onTap;

  const ActivityTabBar({
    super.key,
    required this.selectedActivity,
    required this.onTap,
  });

  final String selectedActivity;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: EdgeInsets.symmetric(horizontal: 10),
      tabAlignment: TabAlignment.start,
      labelPadding: EdgeInsets.all(0),
      isScrollable: true,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: isDarkMode(context) ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode(context)
              ? Colors.white.withOpacity(0.3)
              : Colors.black.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      indicatorWeight: 1,
      tabs: [
        for (var activity in ["All", "Replies", "Mentions", "Follows", "Likes"])
          Tab(
            height: 35,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 3,
              ),
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDarkMode(context)
                      ? Colors.white.withOpacity(0.3)
                      : Colors.black.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: Center(
                  child: Text(
                activity,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.activity,
  });

  final ActionModel activity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      minTileHeight: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileWidget(
            profileUrl: getUrl(width: 40, seed: activity.name),
            withAction: activity.act,
          ),
          Gaps.h8,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.v4,
                          Row(
                            children: [
                              Text(
                                activity.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: -0.5,
                                  height: 1.5,
                                ),
                              ),
                              Gaps.h4,
                              Opacity(
                                opacity: 0.4,
                                child: Text(
                                  "${activity.time < 60 ? activity.time : (activity.time ~/ 60)}${activity.time < 60 ? 'm' : 'h'}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.5,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (activity.describe.isNotEmpty)
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                activity.describe,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  letterSpacing: -0.5,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          if (activity.actDescribe.isNotEmpty)
                            Text(
                              activity.actDescribe,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                letterSpacing: -0.5,
                                height: 1.2,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (activity.act == ActionType.follow)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDarkMode(context)
                                  ? Colors.white.withOpacity(0.3)
                                  : Colors.black.withOpacity(0.3),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Following",
                              style: TextStyle(
                                fontSize: Sizes.size14,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Gaps.v4,
                Divider(
                  thickness: 0.3,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
