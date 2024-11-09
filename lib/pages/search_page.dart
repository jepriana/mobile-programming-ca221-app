import 'package:flutter/material.dart';
import 'package:myapp/resources/dimentions.dart';

import '../widgets/post_item_square.dart';
import '../widgets/search_and_filter.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(largeSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchAndFilter(
            onSubmit: (keyword) {},
          ),
          const SizedBox(
            height: largeSize,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => const PostItemSquare(),
            ),
          ),
        ],
      ),
    );
  }
}
