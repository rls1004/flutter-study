import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/screens/home_screen.dart';
import 'package:threads_clone/screens/nothing_screen.dart';
import 'package:threads_clone/screens/search_screen.dart';
import 'package:threads_clone/utils/fake_generator.dart';
import 'package:threads_clone/screens/write_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final String userName = generateFakeUserName();
  MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    NothingScreen(),
    NothingScreen(),
    NothingScreen(),
  ];

  void _onTap(BuildContext context, int index) {
    if (index == 2) {
      showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        builder: (context) => WriteScreen(userName: widget.userName),
      ).whenComplete(() {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
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
              FontAwesomeIcons.heart,
            ),
            label: "heart",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.user,
            ),
            label: "Home",
          ),
        ],
      ),
    );
  }
}
