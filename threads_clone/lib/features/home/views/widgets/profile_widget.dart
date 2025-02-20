import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/features/activities/models/activity_data_model.dart';
import 'package:threads_clone/utils/utils.dart';

class ProfileWidget extends StatelessWidget {
  final String profileUrl;
  final bool withPlusButton;

  final double radius;
  final ActionType? withAction;
  const ProfileWidget({
    super.key,
    required this.profileUrl,
    this.withPlusButton = false,
    this.radius = 20,
    this.withAction,
  });

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
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor:
                      isDarkMode(context) ? Colors.white : Colors.black,
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    color: isDarkMode(context) ? Colors.black : Colors.white,
                    size: Sizes.size10,
                  ),
                ),
              ),
            ),
          if (withAction == ActionType.mention)
            Positioned(
              bottom: 0,
              left: 27,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.lightGreen,
                  child: FaIcon(
                    FontAwesomeIcons.at,
                    color: Colors.white,
                    size: Sizes.size10,
                  ),
                ),
              ),
            ),
          if (withAction == ActionType.reply)
            Positioned(
              bottom: 0,
              left: 27,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.lightBlue,
                  child: FaIcon(
                    FontAwesomeIcons.reply,
                    color: Colors.white,
                    size: Sizes.size10,
                  ),
                ),
              ),
            ),
          if (withAction == ActionType.follow)
            Positioned(
              bottom: 0,
              left: 27,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.deepPurple,
                  child: FaIcon(
                    FontAwesomeIcons.solidUser,
                    color: Colors.white,
                    size: Sizes.size10,
                  ),
                ),
              ),
            ),
          if (withAction == ActionType.like)
            Positioned(
              bottom: 0,
              left: 27,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.pinkAccent,
                  child: FaIcon(
                    FontAwesomeIcons.solidHeart,
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
