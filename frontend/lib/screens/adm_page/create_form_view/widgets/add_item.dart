import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItem extends StatelessWidget {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35.w,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: fillFormColor),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
        SizedBox(width: 3.w),
        Text(
          'Adicionar campo',
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ],
    );
  }
}
