import 'package:flutter/material.dart';
import 'package:threads_clone/utils/gaps.dart';

class PhotoListWidget extends StatelessWidget {
  final List<String> fileList;
  const PhotoListWidget({super.key, required this.fileList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Gaps.h60,
            for (var i = 0; i < fileList.length; i++) ...[
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 0.5,
                    )),
                child: Image.network(fileList[i]),
              ),
              Gaps.h8,
            ],
          ],
        ),
      ),
    );
  }
}
