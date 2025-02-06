import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/sizes.dart';

class ProfileWidget extends StatelessWidget {
  final String profileUrl;
  final bool withPlusButton;
  final double radius;
  const ProfileWidget(
      {super.key,
      required this.profileUrl,
      this.withPlusButton = false,
      this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: CircleAvatar(
                radius: radius,
                backgroundImage: NetworkImage(profileUrl),
              ),
            ),
          ),
          if (withPlusButton)
            Positioned(
              bottom: 0,
              left: 27,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.black,
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: Sizes.size10,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
