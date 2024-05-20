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
                      SizedBox(height: height * 0.03),
                      user.name == ''
                          ? Text('Olá Administrador!',
                              style: TextStyle(fontSize: 14.sp))
                          : Text('Olá Administrador ${user.name}!',
                              style: TextStyle(fontSize: 14.sp)),
                      SizedBox(height: height * 0.01375),
                      Text('[OrganizationName]',
                          style: TextStyle(fontSize: 14.sp)),
                      SizedBox(height: height * 0.03),
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
                                        return const SizedBox(height: 7);
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index < research.length) {
                                          return SurveyTile(
                                            name: research[index].name,
                                            status: research[index].status,
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
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 33,
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
                                              const SizedBox(height: 27),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Nenhuma pesquisa disponível',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: MyColors.black,
                                      ),
                                    ),
                                  );
                          } else if (state.status == ResearchStatus.loading) {
                            return const Expanded(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'Erro ao buscar pesquisas',
                                style: TextStyle(
                                    fontSize: 14.sp, color: MyColors.black),
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
