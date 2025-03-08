import 'package:final_project/utils/gaps.dart';
import 'package:final_project/utils/sizes.dart';
import 'package:final_project/view_models/analysis_view_model.dart';
import 'package:final_project/view_models/cards_view_model.dart';
import 'package:final_project/view_models/write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomMenuWidget extends ConsumerStatefulWidget {
  final String postID;
  const BottomMenuWidget({super.key, required this.postID});

  @override
  ConsumerState<BottomMenuWidget> createState() => _BottomMenuWidgetState();
}

class _BottomMenuWidgetState extends ConsumerState<BottomMenuWidget> {
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 340;

    void onTapDelete() {
      ref
          .read(writeCardProvider.notifier)
          .deleteCard(context, postID: widget.postID);
      ref.read(cardsProvider.notifier).refresh();
      ref.read(analysisProvider.notifier).refresh();
      context.pop();
    }

    return Container(
      constraints: BoxConstraints(maxHeight: 400),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.size20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(13),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                width: buttonWidth,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 0.7),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 17,
                  ),
                  child: Text(
                    "수정",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size16,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onTapDelete,
                child: Container(
                  width: buttonWidth,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 17,
                    ),
                    child: Text(
                      "삭제",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                        color: Colors.red,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gaps.v32,
        ],
      ),
    );
  }
}
