import 'package:final_project/views/home/home_screen.dart';
import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/users_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupFinishScreen extends ConsumerStatefulWidget {
  static const routeName = "/singup/finish";

  const SignupFinishScreen({super.key});

  @override
  ConsumerState<SignupFinishScreen> createState() => _SignupFinishScreenState();
}

class _SignupFinishScreenState extends ConsumerState<SignupFinishScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _onTapStart() {
    context.go(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(usersProvider)
        .when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => Center(child: CircularProgressIndicator.adaptive()),
          data:
              (data) => Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          spacing: Sizes.size10,
                          children: [
                            Gaps.v10,
                            Text(
                              textAlign: TextAlign.center,
                              "${data.username} 님,\n시작할 준비가 됐어요!",
                              style: TextTheme.of(context).headlineLarge,
                            ),

                            CircleAvatar(
                              radius: Sizes.size80,
                              child: Icon(Icons.woman, size: Sizes.size80),
                            ),

                            GestureDetector(
                              onTap: _onTapStart,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.menu_book_rounded,
                                    size: Sizes.size80,
                                    color: Colors.teal,
                                  ),
                                  Text("눌러서 시작하기"),
                                ],
                              ),
                            ),
                            Gaps.v10,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        );
  }
}
