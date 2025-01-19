import 'package:flutter/material.dart';
import 'package:movieflix/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final String title, thumb, id, posterPath;
  final int width;
  const Movie({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
    required this.posterPath,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
              posterPath: posterPath,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  offset: Offset(0, 0),
                  color: Color(0xFF3D3D3D),
                )
              ],
            ),
            width: width + 0.0,
            height: width + 0.0 - 50,
            child: Image.network(
              thumb,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: width + 0.0,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
