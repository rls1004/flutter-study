import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/utils/gaps.dart';
import 'package:threads_clone/utils/sizes.dart';

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
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 0.2,
        title: Text(
          "Privacy",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () => widget.onTapBack(),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.angleLeft,
                color: Colors.black,
                size: Sizes.size14,
              ),
              Gaps.h5,
              Text(
                "Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            SwitchListTile.adaptive(
              activeColor: Colors.black,
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
                color: Colors.black,
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
                color: Colors.black,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Everyone",
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.black.withOpacity(0.5),
                        )),
                    Gaps.h10,
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
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
                color: Colors.black,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
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
                color: Colors.black,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
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
                color: Colors.black,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: Sizes.size24,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black.withOpacity(0.3),
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
              trailing: Icon(
                Icons.open_in_new,
                size: Sizes.size24,
                color: Colors.black.withOpacity(0.5),
              ),
              subtitle: Text(
                "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black.withOpacity(0.5),
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
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.open_in_new,
                size: Sizes.size24,
                color: Colors.black.withOpacity(0.5),
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
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.open_in_new,
                size: Sizes.size24,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
