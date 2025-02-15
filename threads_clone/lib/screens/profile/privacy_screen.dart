import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';
import 'package:threads_clone/utils/utils.dart';

class PrivacyScreen extends StatefulWidget {
  final Function onTapBack;
  const PrivacyScreen({super.key, required this.onTapBack});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isPrivate = false;

  void _onChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _isPrivate = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: GestureDetector(
            onTap: () => widget.onTapBack(),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.angleLeft,
                  size: Sizes.size14,
                ),
                Gaps.h5,
                Text(
                  "Back",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(height: 0, thickness: 0.3, color: Colors.grey),
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            thumbColor: WidgetStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor),
            inactiveTrackColor: Colors.grey,
            activeColor: isDarkMode(context) ? Colors.white : Colors.black,
            value: _isPrivate,
            onChanged: _onChanged,
            title: Text(
              "Private profile",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            secondary: Icon(
              _isPrivate ? Icons.lock_outline : Icons.lock_open_outlined,
              size: Sizes.size28,
            ),
          ),
          ListTile(
            title: Text(
              "Mentions",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            leading: Icon(
              Icons.alternate_email,
              size: Sizes.size28,
            ),
            trailing: SizedBox(
              width: 100,
              child: Opacity(
                opacity: 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Everyone",
                        style: TextStyle(
                          fontSize: Sizes.size14,
                        )),
                    Gaps.h10,
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Muted",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            leading: Icon(
              Icons.notifications_off_outlined,
              size: Sizes.size28,
            ),
            trailing: SizedBox(
              width: 100,
              child: Opacity(
                opacity: 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Hidden Words",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            leading: Icon(
              Icons.visibility_off_outlined,
              size: Sizes.size28,
            ),
            trailing: SizedBox(
              width: 100,
              child: Opacity(
                opacity: 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Profiles you follow",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            leading: Icon(
              Icons.people_outline,
              size: Sizes.size28,
            ),
            trailing: SizedBox(
              width: 100,
              child: Opacity(
                opacity: 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 0.3,
          ),
          ListTile(
            title: Text(
              "Other privacy settings",
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.open_in_new,
                size: Sizes.size24,
              ),
            ),
            subtitle: Opacity(
              opacity: 0.5,
              child: Text(
                "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                style: TextStyle(
                  fontSize: Sizes.size14,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Other privacy settings",
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Icon(
              Icons.cancel_outlined,
              size: Sizes.size28,
            ),
            trailing: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.open_in_new,
                size: Sizes.size24,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Hide likes",
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Icon(
              Icons.heart_broken_outlined,
              size: Sizes.size28,
            ),
            trailing: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.open_in_new,
                size: Sizes.size24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
