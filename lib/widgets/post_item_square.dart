import 'package:flutter/material.dart';
import 'package:myapp/resources/dimentions.dart';

class PostItemSquare extends StatelessWidget {
  const PostItemSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(smallSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(extraLargeSize),
          image: const DecorationImage(
            // image: AssetImage('assets/images/moments_background_dark.png'),
            image: NetworkImage('https://picsum.photos/800/600?random=3'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
