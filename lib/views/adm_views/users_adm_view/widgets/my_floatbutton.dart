import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';

class MyFloatButton extends StatelessWidget {
  const MyFloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: backGroundColor,
        onPressed: () {},
        child: const Icon(Icons.save, color: Colors.white));
  }
}
