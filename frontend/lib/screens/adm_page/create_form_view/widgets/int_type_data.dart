import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class IntTypeData extends StatefulWidget {
  int identity = 0;
  IntTypeData({super.key, required this.identity});

  @override
  State<IntTypeData> createState() => _IntTypeDataState();
}

class _IntTypeDataState extends State<IntTypeData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(
                width: 50.w,
                child: FormBuilderTextField(
                    key: Key('fieldName_${widget.identity}_min'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      filled: true,
                      fillColor: fillFormColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    name: 'intMin${widget.identity}',
                    keyboardType: TextInputType.number)),
            SizedBox(width: 6.w),
            Text(
              'Mínimo',
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
            SizedBox(width: 10.w),
          ],
        ),
        Row(
          children: [
            SizedBox(
                width: 50.w,
                child: FormBuilderTextField(
                    key: Key('fieldName_${widget.identity}_max'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      filled: true,
                      fillColor: fillFormColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    name: 'intMAx${widget.identity}',
                    keyboardType: TextInputType.number)),
            SizedBox(width: 6.w),
            Text(
              'Máximo',
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
