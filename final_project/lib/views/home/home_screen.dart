import 'package:final_project/data/models/card_model.dart';
import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/cards_view_model.dart';
import 'package:final_project/views/home/widgets/bottom_menu_widget.dart';
import 'package:final_project/views/write/write_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/home";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  CalendarFormat _calendarFormat = CalendarFormat.week;
  final DateTime _today = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final List<String> _emojiList = ["😆", "☺️", "😶‍🌫️", "😢", "😡"];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 15) {
        if (!_isScrolled) {
          setState(() {
            _isScrolled = true;
          });
        }
      } else {
        if (_isScrolled) {
          setState(() {
            _isScrolled = false;
          });
        }
      }
    });
  }

  void _switchFormat() {
    if (_isScrolled) {
      _scrollController.jumpTo(0);
      return;
    }
    if (_calendarFormat == CalendarFormat.week) {
      _calendarFormat = CalendarFormat.month;
    } else {
      _calendarFormat = CalendarFormat.week;
    }

    setState(() {});
  }

  bool _isWeekFormat() {
    return _calendarFormat == CalendarFormat.week;
  }

  void _onTapPrev() {
    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, _today.day);
    setState(() {});
  }

  void _onTapNext() {
    if (_isCurrentMonth()) return;
    _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, _today.day);
    setState(() {});
  }

  bool _isCurrentMonth() {
    return _today.month == _focusedDay.month;
  }

  bool _isSelectToday() {
    return isSameDay(_today, _selectedDay);
  }

  void _onTapWrite() {
    if (!_isSelectToday()) return;

    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: Navigator.of(context, rootNavigator: true).context,
      // isDismissible: false,
      isScrollControlled: true,
      // enableDrag: false,
      // useSafeArea: true,
      builder: (context) => WriteScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 40,
        titleSpacing: 10,
        title: GestureDetector(
          onTap: _switchFormat,
          child: Row(
            children: [
              Text(
                _isWeekFormat()
                    ? _isSelectToday()
                        ? "오늘"
                        : DateFormat.MMMEd('ko_kr').format(_selectedDay)
                    : "월간",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              Icon(
                _isWeekFormat()
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.black,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _isWeekFormat()
                              ? Gaps.v20
                              : Padding(
                                padding: const EdgeInsets.only(
                                  top: Sizes.size10,
                                  bottom: Sizes.size20,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat.yMMMM(
                                        'ko_KR',
                                      ).format(_focusedDay),
                                      style: TextStyle(
                                        fontSize: Sizes.size20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    GestureDetector(
                                      onTap: _onTapPrev,
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: Sizes.size16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Gaps.h20,
                                    GestureDetector(
                                      onTap: _onTapNext,
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: Sizes.size16,
                                        color:
                                            _isCurrentMonth()
                                                ? Colors.transparent
                                                : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          TableCalendar(
                            locale: 'ko_KR',
                            headerVisible: false,
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: _today,
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,

                            onDaySelected: (selectedDay, focusedDay) {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              setState(() {});
                            },
                            selectedDayPredicate: (day) => _selectedDay == day,

                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                              weekendStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            calendarStyle: CalendarStyle(
                              defaultTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              weekendTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              disabledTextStyle: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                              outsideDaysVisible: false,
                              selectedDecoration: BoxDecoration(
                                color:
                                    _isSelectToday()
                                        ? Colors.blue
                                        : Colors.grey.shade800.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              selectedTextStyle: TextStyle(
                                fontSize: Sizes.size16,
                                color:
                                    _isSelectToday()
                                        ? Colors.white
                                        : Colors.lightBlue,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],

        body: LayoutBuilder(
          builder: (context, snapshot) {
            return ref
                .watch(cardsProvider)
                .when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) {
                    return Center(
                      child: Text('Could not load threads: $error'),
                    );
                  },
                  // Center(child: Text('Could not load threads: $error')),
                  data: (data) {
                    Map<int, List<CardModel>> cardsByTime = ref
                        .read(cardsProvider.notifier)
                        .searchByDay(_selectedDay);

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size28,
                          vertical: Sizes.size20,
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _isSelectToday() ? "오늘의 감정" : "이 날의 감정",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: Sizes.size20,
                                      ),
                                    ),

                                    TextButton(
                                      onPressed: _onTapWrite,
                                      style: ButtonStyle(
                                        overlayColor: WidgetStatePropertyAll(
                                          _isSelectToday()
                                              ? Colors.grey.shade100
                                              : Colors.transparent,
                                        ),
                                      ),
                                      child: Text(
                                        "+ 새 감정",
                                        style: TextStyle(
                                          fontSize: Sizes.size14,
                                          color:
                                              _isSelectToday()
                                                  ? Colors.grey.shade700
                                                  : Colors.transparent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                cardsByTime.isEmpty ? EmptyBox() : Container(),
                                for (var cardMap in cardsByTime.entries) ...[
                                  SizedBox(
                                    child: Center(
                                      child: Text(
                                        "${cardMap.key}시",
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Sizes.size10,
                                    child: VerticalDivider(
                                      thickness: Sizes.size2,
                                      color:
                                          cardMap.key < 6
                                              ? Color(0xEF2D3748)
                                              : cardMap.key < 12
                                              ? Color(0xEFEDE9E3)
                                              : cardMap.key < 18
                                              ? Color(0xEFFDE68A)
                                              : cardMap.key < 21
                                              ? Color(0xEFFC7C66)
                                              : Color(0xEF1E293B),
                                    ),
                                  ),

                                  for (var card in cardMap.value) ...[
                                    CardWidget(
                                      card: card,
                                      emojiList: _emojiList,
                                    ),
                                  ],
                                  Gaps.v10,
                                ],
                              ],
                            ),

                            Divider(
                              color: Colors.grey.shade200,
                              height: Sizes.size40,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.card,
    required List<String> emojiList,
  }) : _emojiList = emojiList;

  final CardModel card;
  final List<String> _emojiList;

  @override
  Widget build(BuildContext context) {
    void onTapEllips(String postID) {
      showModalBottomSheet(
        backgroundColor: Colors.black,
        context: Navigator.of(context, rootNavigator: true).context,
        // isDismissible: false,
        isScrollControlled: true,
        // enableDrag: false,
        // useSafeArea: true,
        builder: (context) => BottomMenuWidget(postID: postID),
      );
    }

    Color backgroundCardColor = Colors.grey.shade200;
    Color fontColor = Colors.black;
    fontColor = Colors.white;
    backgroundCardColor = Color(0xEF1E293B);

    if (card.recordTime < 21) {
      fontColor = Colors.black87;
      backgroundCardColor = Color(0xEFFC7C66);
    }
    if (card.recordTime < 18) {
      fontColor = Colors.black87;
      backgroundCardColor = Color(0xEFFDE68A);
    }
    if (card.recordTime < 12) {
      fontColor = Colors.black87;
      backgroundCardColor = Color(0xEFEDE9E3);
    }
    if (card.recordTime < 6) {
      fontColor = Colors.white;
      backgroundCardColor = Color(0xEF2D3748);
    }

    return Container(
      margin: EdgeInsets.only(bottom: Sizes.size10),
      padding: EdgeInsets.only(
        left: Sizes.size12,
        right: Sizes.size12,
        top: Sizes.size10,
        bottom: Sizes.size20,
      ),
      decoration: BoxDecoration(
        // color: Colors.grey.shade200,
        color: backgroundCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => onTapEllips(card.postID!),
                child: Container(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: Sizes.size14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      card.contents,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w400,
                        color: fontColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  _emojiList[card.emoji],
                  style: TextStyle(fontSize: Sizes.size44),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Text("Empty", style: TextStyle(color: Colors.grey.shade500)),
      ),
    );
  }
}
