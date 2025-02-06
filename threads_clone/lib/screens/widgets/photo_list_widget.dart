import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/utils/fake_generator.dart';

class PhotoListWidget extends StatelessWidget {
  final int numOfPhotos;
  const PhotoListWidget({super.key, required this.numOfPhotos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Gaps.h60,
            for (var i = 0; i < numOfPhotos; i++) ...[
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 0.5,
                    )),
                child: Image.network(getUrl(width: 270, height: 170)),
              ),
              Gaps.h8,
            ],
          ],
        ),
      ),
    );
  }
}
