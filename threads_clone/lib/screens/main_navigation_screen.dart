import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/screens/home_screen.dart';
import 'package:threads_clone/screens/nothing_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screens = [
    HomeScreen(),
    NothingScreen(),
    NothingScreen(),
    NothingScreen(),
    NothingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onTap,
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
