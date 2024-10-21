import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      color: Colors.amberAccent,
      margin: const EdgeInsets.all(8.0),
    );
  }
}
