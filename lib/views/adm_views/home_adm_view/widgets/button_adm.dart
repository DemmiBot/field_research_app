import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButtonAdm extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  const MyButtonAdm(
      {super.key,
      required this.text,
      required this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: width.w,
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll(
          Color(0xFF1B1F27),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.white)),
    );
  }
}
