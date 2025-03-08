import 'package:final_project/views/analysis/analysis_screen.dart';
import 'package:final_project/views/home/home_screen.dart';
import 'package:final_project/views/noting_screens.dart';
import 'package:final_project/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends StatefulWidget {
  final Widget child;
  const MainNavigationScreen({super.key, required this.child});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        context.go(HomeScreen.routeName);
        break;
      case 1:
        context.go(AnalysisScreen.routeName);
        break;
      case 2:
        context.go(NothingScreens.routeName);
        break;
      case 3:
        context.go(NothingScreens.routeName);
        break;
      case 4:
        context.go(ProfileScreen.routeName);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (index) => _onTap(context, index),
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bookQuran),
            label: "감정",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.chartSimple),
            label: "분석",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: "프로그램",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.crown),
            label: "랭킹",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: "프로필",
          ),
        ],
      ),
    );
  }
}
