import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class ResearchesAdmView extends StatefulWidget {
  const ResearchesAdmView({super.key});

  @override
  State<ResearchesAdmView> createState() => _ResearchesAdmViewState();
}

class _ResearchesAdmViewState extends State<ResearchesAdmView> {
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
                      SizedBox(height: 22.h),
                      user.name == ''
                          ? ShimmerUserInfo()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bem vindo, ${user.name}!',
                                    style: TextStyle(fontSize: 14.sp)),
                                SizedBox(height: 11.h),
                                Text('[OrganizationName]',
                                    style: TextStyle(fontSize: 14.sp)),
                              ],
                            ),
                      SizedBox(height: 26.h),
                      const Divider(color: MyColors.dividerColor),
                      BlocBuilder<ResearchModelBloc, ResearchModelState>(
                        builder: (context, state) {
                          if (state.status == ResearchStatus.success) {
                            research = state.researches!;
                            return research.isNotEmpty
                                ? Expanded(
                                    child: ListView.separated(
                                      itemCount: research.length + 1,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(height: 7.h);
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index < research.length) {
                                          return Column(
                                            children: [
                                              if (index == 0)
                                                SizedBox(height: 20.h),
                                              SurveyTile.admin(
                                                research: research[index],
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton.icon(
                                                style: const ButtonStyle(
                                                  elevation:
                                                      MaterialStatePropertyAll(
                                                          0),
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                    MyColors.white,
                                                  ),
                                                  side:
                                                      MaterialStatePropertyAll(
                                                    BorderSide(
                                                      color:
                                                          MyColors.primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      '/admCreateForm');
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 33.h,
                                                  color: MyColors.primaryColor,
                                                ),
                                                label: Text(
                                                  'Nova pesquisa',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: MyColors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 27.h),
                                            ],
                                          );
                                        }
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
                                      if (index == 0) SizedBox(height: 20.h),
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
                                      fontSize: 14.sp, color: MyColors.black),
                                ),
                              ),
                            );
                          }
                        },
                      ),
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
