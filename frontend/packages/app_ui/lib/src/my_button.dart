import 'package:app_ui/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  const MyButton.loading({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 40.h, maxWidth: 136.w),
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(MyColors.primaryColor),
                // padding: MaterialStateProperty.all(
                //   EdgeInsets.symmetric(horizontal: 1.w, vertical: 9.h),
                // ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              child: widget.isLoading
                  ? Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          color: MyColors.white,
                          secondRingColor: MyColors.textFill,
                          thirdRingColor: MyColors.borderField,
                          size: 20.sp),
                    )
                  : Center(
                      child: Text(
                        widget.text,
                        style:
                            TextStyle(fontSize: 16.sp, color: MyColors.white),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
