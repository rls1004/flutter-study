import 'package:flutter/material.dart';
import 'package:threads_clone/utils/fake_generator.dart';

class RepliesImageWidget extends StatelessWidget {
  final int num;
  const RepliesImageWidget({super.key, required this.num});

  @override
  Widget build(BuildContext context) {
    switch (num) {
      case 0:
        return SizedBox(
          width: 54,
          height: 50,
        );

      case 1:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
              width: 0.3,
            ),
          ),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(getUrl(width: 40)),
          ),
        );

      case 2:
        return Center(
          child: SizedBox(
            width: 40,
            height: 50,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 15,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                          width: 0.3,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(getUrl(width: 40)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    // left: 15,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 0.3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(getUrl(width: 40)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      case 3:
      default:
        return SizedBox(
          width: 45,
          height: 50,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 13,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 0.3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundImage: NetworkImage(getUrl(width: 40)),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 0.3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(getUrl(width: 40)),
                  ),
                ),
              ),
              Positioned(
                top: 28,
                left: 17,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 0.3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 6.5,
                    backgroundImage: NetworkImage(getUrl(width: 40)),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}
