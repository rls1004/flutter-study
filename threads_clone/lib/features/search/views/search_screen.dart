import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/features/search/models/search_data_model.dart';
import 'package:threads_clone/features/search/views/widgets/search_user_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SearchDataModel> userList = [];
  String searchText = "";

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 30; i++) {
      userList.add(generateFakeUserList());
    }
  }

  void _onChanged(value) {
    setState(() {
      searchText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 110,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
            Gaps.v5,
            CupertinoSearchTextField(
              onChanged: _onChanged,
            ),
          ],
        ),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Gaps.v10,
          for (var userInfo in userList)
            if (searchText.isEmpty ||
                (searchText.isNotEmpty &&
                    userInfo.userName.contains(searchText)))
              SearchUserWidget(userInfo: userInfo),
        ],
      ),
    );
  }
}
