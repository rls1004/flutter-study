import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/screens/features/activity_info.dart';
import 'package:threads_clone/screens/widgets/profile_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String selectedActivity = "All";
  List<ActionInfo> activities = [];

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
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          surfaceTintColor: Colors.transparent,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gaps.v20,
              for (var activity in activities)
                if (selectedActivity == "All" ||
                    (selectedActivity == "Replies" &&
                        activity.act == ActionType.reply) ||
                    (selectedActivity == "Mentions" &&
                        activity.act == ActionType.mention) ||
                    (selectedActivity == "Follows" &&
                        activity.act == ActionType.follow) ||
                    (selectedActivity == "Likes" &&
                        activity.act == ActionType.like))
                  ActivityTile(activity: activity),
            ],
          ),
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
      indicatorColor: Colors.transparent,
      tabs: [
        for (var activity in ["All", "Replies", "Mentions", "Follows", "Likes"])
          GestureDetector(
            onTap: () => onTap(activity),
            child: Tab(
              height: 35,
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 3,
                ),
                width: 100,
                height: 35,
                decoration: BoxDecoration(
                  color: selectedActivity == activity
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
                child: Center(
                    child: Text(
                  activity,
                  style: TextStyle(
                    color: selectedActivity == activity
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
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

  final ActionInfo activity;

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
                              Text(
                                "${activity.time < 60 ? activity.time : (activity.time ~/ 60)}${activity.time < 60 ? 'm' : 'h'}",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: -0.5,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                          if (activity.describe.isNotEmpty)
                            Text(
                              activity.describe,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                letterSpacing: -0.5,
                                height: 1.2,
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
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.3),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Following",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Gaps.v4,
                Divider(
                  color: Colors.black.withOpacity(0.2),
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
