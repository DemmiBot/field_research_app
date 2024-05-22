import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:research_repository/research_repository.dart';

// widget for discovered searches
class SurveyTile extends StatelessWidget {
  final ResearchModel research;

  final bool typeUser;

  const SurveyTile.user({
    super.key,
    required this.research,
  }) : typeUser = true;

  const SurveyTile.admin({
    super.key,
    required this.research,
  }) : typeUser = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () =>
          typeUser ? Navigator.pushNamed(context, '/surveySubmission') : () {},
      dense: true,
      trailing: typeUser
          ? IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(
                Icons.help_outline,
                size: 26.sp,
                color: MyColors.primaryColor,
              ),
            )
          : null,
      title: Text(
        research.name,
        style: TextStyle(fontSize: 14.sp, color: MyColors.black),
      ),
      subtitle: Row(
        children: [
          Container(
            width: 4.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: research.status == 'OPEN' ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            ' ${translate(research.status)} | 1246 entradas | 4 pesquisadores',
            style: TextStyle(
              fontSize: 10.sp,
              color: MyColors.black,
            ),
          ),
        ],
      ),
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
