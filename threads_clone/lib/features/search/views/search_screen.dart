import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/features/home/views/widgets/post_card_widget.dart';
import 'package:threads_clone/features/profiles/view_models/setting_config_vm.dart';
import 'package:threads_clone/features/common/view_models/threads_view_model.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/features/search/models/search_data_model.dart';
import 'package:threads_clone/features/search/views/widgets/search_user_widget.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/utils/utils.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const routeName = "/search";
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchControler = TextEditingController();
  List<SearchDataModel> userList = [];
  String searchText = "";
  bool _isSearching = false;
  bool _isThreadSearching = false;
  double appBarSize = 110;
  final int _duration = 200;

  List<String> searchHistory = [];

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

  void _onTapSearch() {
    _isSearching = true;
    _isThreadSearching = false;
    Future.delayed(Duration(milliseconds: _duration), () {
      appBarSize = 45;
      setState(() {});
    });
    setState(() {});
  }

  void _onTapSearchBack() {
    _isSearching = false;
    _isThreadSearching = false;
    searchText = "";
    _searchControler.text = "";
    appBarSize = 110;
    setState(() {});
  }

  void _onTapThreadSearch() {
    _isThreadSearching = true;
    ref.read(settingConfigProvider.notifier).addHistory(searchText);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    searchHistory = ref.watch(settingConfigProvider).searchHistory;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: appBarSize,
        title: SizedBox(
          height: appBarSize,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Column(
                  children: [
                    !_isSearching
                        ? Align(
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
                          )
                        : Gaps.v1,
                    Gaps.v5,
                  ],
                ),
              ),
              Positioned(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      width: !_isSearching ? 0 : 30,
                      duration: Duration(milliseconds: _duration),
                      curve: Curves.ease,
                      alignment: !_isSearching
                          ? Alignment.bottomCenter
                          : Alignment.topCenter,
                      child: _isSearching
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: GestureDetector(
                                onTap: _onTapSearchBack,
                                child: Icon(Icons.arrow_back_ios_new_rounded),
                              ),
                            )
                          : SizedBox(),
                    ),
                    AnimatedContainer(
                      width: !_isSearching
                          ? MediaQuery.of(context).size.width - 40
                          : MediaQuery.of(context).size.width - 40 - 30,
                      padding: !_isSearching
                          ? EdgeInsets.all(0)
                          : EdgeInsets.only(left: 10),
                      alignment: !_isSearching
                          ? Alignment.bottomCenter
                          : Alignment.topCenter,
                      duration: Duration(milliseconds: _duration),
                      curve: Curves.ease,
                      child: CupertinoSearchTextField(
                        controller: _searchControler,
                        onTap: _onTapSearch,
                        onChanged: _onChanged,
                        style: TextStyle(
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: _duration),
        child: appBarSize == 110
            ? ProfileSearchPage(userList: userList, searchText: searchText)
            : searchText.isEmpty
                ? WaitForSearch(searchHistory: searchHistory)
                : !_isThreadSearching
                    ? SearchSuggestion(
                        searchText: searchText,
                        userList: userList,
                        onTapThreadSearch: _onTapThreadSearch)
                    : DetailSearchPage(
                        searchText: searchText, userList: userList),
      ),
    );
  }
}

class DetailSearchPage extends StatelessWidget {
  const DetailSearchPage({
    super.key,
    required this.searchText,
    required this.userList,
  });

  final String searchText;
  final List<SearchDataModel> userList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.grey,
            indicatorColor: isDarkMode(context) ? Colors.white : Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: isDarkMode(context) ? Colors.white : Colors.black,
            unselectedLabelColor: isDarkMode(context)
                ? Colors.white.withOpacity(0.5)
                : Colors.black.withOpacity(0.5),
            tabs: [
              Tab(text: "Popular"),
              Tab(text: "Recent"),
              Tab(text: "Profile"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ThreadSearchPage(
                  searchText: searchText,
                  orderByPopular: true,
                ),
                ThreadSearchPage(
                  searchText: searchText,
                ),
                ProfileSearchPage(userList: userList, searchText: searchText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchSuggestion extends StatelessWidget {
  final Function onTapThreadSearch;
  const SearchSuggestion({
    super.key,
    required this.searchText,
    required this.userList,
    required this.onTapThreadSearch,
  });

  final String searchText;
  final List<SearchDataModel> userList;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GestureDetector(
          onTap: () => onTapThreadSearch(),
          child: ListTile(
            minTileHeight: 50,
            leading: Icon(
              CupertinoIcons.search,
              size: Sizes.size20,
            ),
            title: Text("'$searchText' search"),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: Sizes.size16,
            ),
          ),
        ),
        Opacity(
          opacity: 0.7,
          child: Divider(
            thickness: 0.7,
            indent: 50,
            height: 10,
          ),
        ),
        Gaps.v10,
        for (var userInfo in userList)
          if (searchText.isEmpty ||
              (searchText.isNotEmpty && userInfo.userName.contains(searchText)))
            SearchUserWidget(userInfo: userInfo),
      ],
    );
  }
}

class WaitForSearch extends StatelessWidget {
  const WaitForSearch({
    super.key,
    required this.searchHistory,
  });

  final List<String> searchHistory;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recents",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Delete",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        for (var searchText in searchHistory) ...[
          ListTile(
            minTileHeight: 50,
            leading: Icon(
              CupertinoIcons.search,
              size: Sizes.size20,
            ),
            title: Text(searchText),
            trailing: Icon(
              CupertinoIcons.xmark,
              size: Sizes.size16,
            ),
          ),
          Opacity(
            opacity: 0.7,
            child: Divider(
              thickness: 0.7,
              indent: 50,
              height: 10,
            ),
          ),
        ]
      ],
    );
  }
}

class ProfileSearchPage extends StatelessWidget {
  const ProfileSearchPage({
    super.key,
    required this.userList,
    required this.searchText,
  });

  final List<SearchDataModel> userList;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        Gaps.v10,
        for (var userInfo in userList)
          if (searchText.isEmpty ||
              (searchText.isNotEmpty && userInfo.userName.contains(searchText)))
            SearchUserWidget(userInfo: userInfo),
      ],
    );
  }
}

class ThreadSearchPage extends ConsumerStatefulWidget {
  final String searchText;
  final bool orderByPopular;
  const ThreadSearchPage(
      {super.key, required this.searchText, this.orderByPopular = false});

  @override
  ConsumerState<ThreadSearchPage> createState() => _ThreadSearchPageState();
}

class _ThreadSearchPageState extends ConsumerState<ThreadSearchPage> {
  @override
  Widget build(BuildContext context) {
    final filteredThread = ref
        .watch(threadsProvider.notifier)
        .search(widget.searchText, popular: widget.orderByPopular);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: filteredThread.isEmpty ? 1 : filteredThread.length,
            itemBuilder: (context, index) {
              return filteredThread.isEmpty
                  ? Center(
                      heightFactor: 3,
                      child: Text("No result."),
                    )
                  : PostCardWidget(postData: filteredThread[index]);
            },
          )
        ],
      ),
    );
  }
}
