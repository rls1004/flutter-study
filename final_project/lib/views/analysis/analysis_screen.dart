import 'dart:math';

import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/analysis_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AnalysisScreen extends ConsumerStatefulWidget {
  static const routeName = "/analysis";
  const AnalysisScreen({super.key});

  @override
  ConsumerState<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends ConsumerState<AnalysisScreen> {
  String weekTitleFormat = "";
  String startOfWeekFormat = "";
  String endOfWeekFormat = "";
  DateTime now = DateTime.now();
  DateTime thisWeek = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void _onTapBack() {
    now = now.subtract(Duration(days: 7));
    ref.read(analysisProvider.notifier).changeBaseWeek(back: true);
    setState(() {});
  }

  void _onTapFoward() {
    now = now.add(Duration(days: 7));
    ref.read(analysisProvider.notifier).changeBaseWeek(back: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = now.add(Duration(days: 7 - now.weekday));

    startOfWeekFormat = DateFormat.MMMEd('ko_kr').format(startOfWeek);
    endOfWeekFormat = DateFormat.MMMEd('ko_kr').format(endOfWeek);

    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    int firstWeekday = firstDayOfMonth.weekday;

    int weekNumber = (now.day + firstWeekday - 2) ~/ 7 + 1;
    weekTitleFormat = "${now.month}월 $weekNumber주차";

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              spacing: Sizes.size20,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weekTitleFormat,
                          style: TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "$startOfWeekFormat ~ $endOfWeekFormat",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    Expanded(child: Container()),

                    IconButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: _onTapBack,
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: Sizes.size20,
                      ),
                    ),
                    IconButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed:
                          isSameDay(now, thisWeek) ? () {} : _onTapFoward,
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: Sizes.size20,
                        color:
                            isSameDay(now, thisWeek)
                                ? Colors.grey
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
                WeeklyStatistics(),
                CompareToLastWeek(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompareToLastWeek extends ConsumerStatefulWidget {
  const CompareToLastWeek({super.key});

  @override
  ConsumerState<CompareToLastWeek> createState() => _CompareToLastWeekState();
}

class _CompareToLastWeekState extends ConsumerState<CompareToLastWeek> {
  final List<String> _emojiList = ["😆", "☺️", "😶‍🌫️", "😢", "😡"];
  double maxY = 20;

  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: Sizes.size10,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sizes.size10),
            topLeft: Radius.circular(Sizes.size10),
          ),
        ),
        BarChartRodData(
          toY: shadowValue,
          color: Colors.grey.shade400,
          width: Sizes.size10,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sizes.size10),
            topLeft: Radius.circular(Sizes.size10),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<_BarData> dataList = [];

    ref
        .watch(analysisProvider)
        .when(
          loading: () {},
          error: (error, stackTrace) {},
          data: (data) {
            List<double> emojiThisWeek =
                ref.read(analysisProvider.notifier).getCountByEmojiThisWeek();
            List<double> emojiLastWeek =
                ref.read(analysisProvider.notifier).getCountByEmojiLastWeek();

            dataList = [
              _BarData(Colors.blueGrey, emojiThisWeek[0], emojiLastWeek[0]),
              _BarData(Colors.blueGrey, emojiThisWeek[1], emojiLastWeek[1]),
              _BarData(Colors.blueGrey, emojiThisWeek[2], emojiLastWeek[2]),
              _BarData(Colors.blueGrey, emojiThisWeek[3], emojiLastWeek[3]),
              _BarData(Colors.blueGrey, emojiThisWeek[4], emojiLastWeek[4]),
            ];

            maxY = -1;
            for (var cnt in emojiThisWeek) {
              maxY = max(maxY, cnt);
            }
            for (var cnt in emojiLastWeek) {
              maxY = max(maxY, cnt);
            }

            maxY = max(maxY, ((maxY + 5) - (maxY % 5)));
          },
        );

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size20,
          horizontal: Sizes.size20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  '지난주와 이렇게 달라졌어요.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  rotationQuarterTurns: 1,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: const AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: Sizes.size32,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: Sizes.size36,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              _emojiList[value.round()],
                              style: TextStyle(fontSize: Sizes.size28),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine:
                        (value) =>
                            FlLine(color: Colors.grey.shade400, strokeWidth: 1),
                  ),
                  barGroups:
                      dataList.asMap().entries.map((e) {
                        final index = e.key;
                        final data = e.value;
                        return generateBarGroup(
                          index,
                          data.color,
                          data.value,
                          data.shadowValue,
                        );
                      }).toList(),
                  maxY: maxY,
                  barTouchData: BarTouchData(enabled: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyStatistics extends ConsumerStatefulWidget {
  const WeeklyStatistics({super.key});

  @override
  ConsumerState<WeeklyStatistics> createState() => _WeeklyStatisticsState();
}

class _WeeklyStatisticsState extends ConsumerState<WeeklyStatistics> {
  final Color barColor = Colors.blueGrey;
  final Color barBackgroundColor = Colors.grey.shade300;

  double day1Count = 0;
  double day2Count = 0;
  double day3Count = 0;
  double day4Count = 0;
  double day5Count = 0;
  double day6Count = 0;
  double day7Count = 0;

  int dayTotal = 0;

  BarChartGroupData makeGroupData(int x, double y, {double maxY = 15}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: Sizes.size24,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxY,
            color: barBackgroundColor,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
    double maxY = -1;
    for (var cnt in [
      day1Count,
      day2Count,
      day3Count,
      day4Count,
      day5Count,
      day6Count,
      day7Count,
    ]) {
      maxY = max(maxY, cnt);
    }
    maxY = max(maxY, ((maxY + 5) - (maxY % 5)));
    switch (i) {
      case 0:
        return makeGroupData(0, day1Count, maxY: maxY);
      case 1:
        return makeGroupData(1, day2Count, maxY: maxY);
      case 2:
        return makeGroupData(2, day3Count, maxY: maxY);
      case 3:
        return makeGroupData(3, day4Count, maxY: maxY);
      case 4:
        return makeGroupData(4, day5Count, maxY: maxY);
      case 5:
        return makeGroupData(5, day6Count, maxY: maxY);
      case 6:
        return makeGroupData(6, day7Count, maxY: maxY);
      default:
        return throw Error();
    }
  });

  @override
  Widget build(BuildContext context) {
    ref
        .watch(analysisProvider)
        .when(
          data: (d) {
            day1Count = ref.watch(analysisProvider.notifier).getCountByDay(1);
            day2Count = ref.watch(analysisProvider.notifier).getCountByDay(2);
            day3Count = ref.watch(analysisProvider.notifier).getCountByDay(3);
            day4Count = ref.watch(analysisProvider.notifier).getCountByDay(4);
            day5Count = ref.watch(analysisProvider.notifier).getCountByDay(5);
            day6Count = ref.watch(analysisProvider.notifier).getCountByDay(6);
            day7Count = ref.watch(analysisProvider.notifier).getCountByDay(7);

            dayTotal =
                (day1Count +
                        day2Count +
                        day3Count +
                        day4Count +
                        day5Count +
                        day6Count +
                        day7Count)
                    .round();
          },
          error: (_, __) {},
          loading: () {},
        );
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.size20,
        horizontal: Sizes.size20,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(Sizes.size10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "주간 통계",
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$dayTotal 개의 감정",
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: Sizes.size20, bottom: Sizes.size10),
            height: Sizes.size80 * Sizes.size3,
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getTitles,
                      reservedSize: 38,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: showingGroups(),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.value, this.shadowValue);

  final Color color;
  final double value;
  final double shadowValue;
}

Widget getTitles(double value, TitleMeta meta) {
  TextStyle style = TextStyle(
    color: Colors.grey.shade700,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('월', style: style);
      break;
    case 1:
      text = Text('화', style: style);
      break;
    case 2:
      text = Text('수', style: style);
      break;
    case 3:
      text = Text('목', style: style);
      break;
    case 4:
      text = Text('금', style: style);
      break;
    case 5:
      text = Text('토', style: style);
      break;
    case 6:
      text = Text('일', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }
  return SideTitleWidget(meta: meta, space: Sizes.size16, child: text);
}
