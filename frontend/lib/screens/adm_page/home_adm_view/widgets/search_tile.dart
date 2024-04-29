import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SearchTile extends StatefulWidget {
  late String name;
  late String status;
  SearchTile({super.key, required this.name, required this.status});

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.name,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Container(
              width: 4.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: widget.status == 'OPEN' ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              ' ${widget.status} | 1246 entradas',
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
