import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObrigatoryField extends StatefulWidget {
  const ObrigatoryField({super.key});

  @override
  State<ObrigatoryField> createState() => _ObrigatoryFieldState();
}

class _ObrigatoryFieldState extends State<ObrigatoryField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(3.r),
              color: fillFormColor),
          child: const Checkbox(value: true, onChanged: null),
        ),
        SizedBox(width: 3.w),
        Text(
          'Obrigatório',
          style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
        ),
      ],
    );
  }
}
