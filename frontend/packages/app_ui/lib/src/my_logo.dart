import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'SURVEY',
        style: TextStyle(
          color: MyColors.black,
          fontSize: 40,
          fontWeight: FontWeight.w900,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'APP',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: MyColors.primaryColor,
                fontSize: 40),
          ),
        ],
      ),
    );
  }
}
