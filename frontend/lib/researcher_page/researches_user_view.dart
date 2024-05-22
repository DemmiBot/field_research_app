import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class ResearchesUserView extends StatefulWidget {
  const ResearchesUserView({super.key});

  @override
  State<ResearchesUserView> createState() => _ResearchesUserViewState();
}

class _ResearchesUserViewState extends State<ResearchesUserView> {
  List<ResearchModel> research = [];

  UserModel user = UserModel.empty;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return BlocBuilder<UserModelBloc, UserModelState>(
          builder: (context, state) {
            if (state.status == GetStatus.success) {
              user = state.user!;
            }
            return SafeArea(
              child: RefreshIndicator(
                color: MyColors.primaryColor,
                onRefresh: () async =>
                    context.read<ResearchModelBloc>().add(GetAllResearches()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.03),
                      user.name == ''
                          ? ShimmerUserInfo(height: height)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bem vindo, ${user.name}!',
                                    style: TextStyle(fontSize: 14.sp)),
                                SizedBox(height: height * 0.01375),
                                Text('[OrganizationName]',
                                    style: TextStyle(fontSize: 14.sp)),
                              ],
                            ),
                      SizedBox(height: height * 0.03),
                      const Divider(color: MyColors.dividerColor),
                      BlocBuilder<ResearchModelBloc, ResearchModelState>(
                          builder: (context, state) {
                        if (state.status == ResearchStatus.success) {
                          research = state.researches!;
                          return research.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: research.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          if (index == 0)
                                            SizedBox(height: height * 0.03),
                                          SurveyTile.user(
                                            research: research[index],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                    child: Text(
                                      'Nenhuma pesquisa disponível',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: MyColors.black,
                                      ),
                                    ),
                                  ),
                                );
                        } else if (state.status == ResearchStatus.loading) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    if (index == 0)
                                      SizedBox(height: height * 0.03),
                                    const ShimmerSurveyTile()
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Center(
                              child: Text(
                                'Erro ao buscar pesquisas',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
