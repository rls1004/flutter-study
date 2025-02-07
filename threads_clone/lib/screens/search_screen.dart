import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/screens/widgets/search_user_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, String>> userList = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 30; i++) userList.add(generateFakeUserList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: Sizes.size80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search",
              style: TextStyle(
                fontSize: Sizes.size32,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            Gaps.v5,
            CupertinoSearchTextField(),
          ],
        ),
      ),
      body: ListView(
        children: [
          Gaps.v10,
          for (var userInfo in userList) SearchUserWidget(userInfo: userInfo),
        ],
      ),
    );
  }
}
