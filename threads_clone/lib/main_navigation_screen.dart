import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/features/activities/views/activity_screen.dart';
import 'package:threads_clone/features/home/views/home_screen.dart';
import 'package:threads_clone/features/profiles/views/profile_screen.dart';
import 'package:threads_clone/features/search/views/search_screen.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/features/write/views/write_screen.dart';
import 'package:threads_clone/utils/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  final Widget child;
  final String userName = generateFakeUserName();
  MainNavigationScreen({super.key, required this.child});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(BuildContext context, int index) {
    if (index == 2) {
      showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        builder: (context) => WriteScreen(),
      ).whenComplete(() {
        SystemChrome.setSystemUIOverlayStyle(isDarkMode(context)
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }

    switch (_selectedIndex) {
      case 0:
        context.go(HomeScreen.routeName);
        break;
      case 1:
        context.go(SearchScreen.routeName);
        break;
      case 3:
        context.go(ActivityScreen.routeName);
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
      body: widget.child, //_screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) => _onTap(context, index),
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.feather,
            ),
            label: "write",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              _selectedIndex == 3
                  ? FontAwesomeIcons.solidHeart
                  : FontAwesomeIcons.heart,
            ),
            label: "heart",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              _selectedIndex == 4
                  ? FontAwesomeIcons.solidUser
                  : FontAwesomeIcons.user,
            ),
            label: "Home",
          ),
        ],
      ),
    );
  }
}
