import 'package:flutter/material.dart';
import 'package:y/constants/gaps.dart';
import 'package:y/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('X'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: Sizes.size20,
          ),
          child: Row(
            children: [
              Text(
                'Have an account already?',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.h5,
              Text('Log in',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizes.size16,
                  )),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                'See what\'s happening in the world right now.',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gaps.v80,
            ],
          ),
        ),
      ),
    );
  }
}
