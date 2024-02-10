import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleMore extends StatelessWidget {
  const CircleMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: fillFormColor),
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.expand_more_rounded,
            color: Colors.white,
          )),
    );
  }
}
