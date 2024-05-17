import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: RichText(
        text: TextSpan(
          text: 'SURVEY',
          style: TextStyle(
            color: MyColors.black,
            fontSize: 40.sp,
            fontWeight: FontWeight.w900,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'APP',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: MyColors.primaryColor,
                  fontSize: 40.sp),
            ),
          ],
        ),
      ),
    );
  }
}
