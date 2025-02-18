import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/screens/widgets/post_card_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: FaIcon(
                FontAwesomeIcons.threads,
                size: Sizes.size40,
              ),
            ),
            SliverList.list(children: getThreads("")),
          ],
        ),
      ),
    );
  }
}
