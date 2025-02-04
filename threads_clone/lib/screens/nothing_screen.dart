import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/sizes.dart';

class NothingScreen extends StatelessWidget {
  const NothingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: FaIcon(
              FontAwesomeIcons.threads,
              size: Sizes.size40,
              color: Colors.black,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text("Empty"),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
