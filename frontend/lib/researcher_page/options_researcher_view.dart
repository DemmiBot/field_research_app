import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsResearcherView extends StatefulWidget {
  const OptionsResearcherView({super.key});

  @override
  State<OptionsResearcherView> createState() => _OptionsResearcherViewState();
}

class _OptionsResearcherViewState extends State<OptionsResearcherView> {
  bool selected = false;
  bool selected2 = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.03),
                Text(
                  'Opções da organização',
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: height * 0.011),
                const Divider(color: MyColors.dividerColor),
                SizedBox(height: height * 0.041),
                Text(
                  'Opções da organização',
                  style: TextStyle(
                      fontSize: 13.sp, color: MyColors.variantPrimaryColor),
                ),
                SizedBox(height: height * 0.025),
                Column(
                  children: [
                    SizedBox(height: height * 0.025),
                    layoutSwitch(),
                    SizedBox(height: height * 0.025),
                    layoutSwitch(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget layoutSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Opções da organização',
          style: TextStyle(fontSize: 12.sp),
        ),
        const SizedBox(height: 1),
        Container(
          width: 1,
          height: 24,
          color: MyColors.secondaryButton,
        ),
        Switch(
          activeColor: MyColors.primaryColor,
          value: selected,
          onChanged: (value) {
            setState(() {
              selected = !selected;
            });
          },
        ),
      ],
    );
  }
}
