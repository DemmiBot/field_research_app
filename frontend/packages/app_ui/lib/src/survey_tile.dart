import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// widget for discovered searches
class SurveyTile extends StatelessWidget {
  final String name;
  final String status;
  const SurveyTile({super.key, required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            name,
            style: TextStyle(fontSize: 14.sp, color: MyColors.black),
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Container(
              width: 4.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: status == 'OPEN' ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              ' ${translate(status)} | 1246 entradas | 4 pesquisador(es)',
              style: TextStyle(fontSize: 10.sp, color: MyColors.black),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  String translate(final String status) {
    if (status == 'OPEN') {
      return 'Aberto';
    } else {
      return 'Fechado';
    }
  }
}
