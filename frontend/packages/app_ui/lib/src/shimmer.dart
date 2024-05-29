import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSurveyTile extends StatelessWidget {
  const ShimmerSurveyTile({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmerBaseColor = Colors.grey[300];
    final shimmerHighlightColor = Colors.grey[100];

    return Shimmer.fromColors(
      baseColor: shimmerBaseColor!,
      highlightColor: shimmerHighlightColor!,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Container(
          height: 16.h,
          color: shimmerBaseColor,
        ),
        subtitle: Row(
          children: [
            Container(
              width: 4.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: shimmerBaseColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
            Container(
              width: 100.w,
              height: 10.h,
              color: shimmerBaseColor,
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerUserInfo extends StatelessWidget {
  ShimmerUserInfo({super.key});

  final shimmerBaseColor = Colors.grey[300];
  final shimmerHighlightColor = Colors.grey[100];

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor!,
      highlightColor: shimmerHighlightColor!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 170.w,
            height: 21.h,
            color: shimmerBaseColor,
          ),
          SizedBox(height: 11.h),
          Container(
            width: 145.w,
            height: 21.h,
            color: shimmerBaseColor,
          ),
        ],
      ),
    );
  }
}
