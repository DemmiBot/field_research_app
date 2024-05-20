import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class ResearchesView extends StatefulWidget {
  const ResearchesView({super.key});

  @override
  State<ResearchesView> createState() => _ResearchesViewState();
}

class _ResearchesViewState extends State<ResearchesView> {
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
                          ? Text('Bem vindo!',
                              style: TextStyle(fontSize: 14.sp))
                          : Text('Bem vindo, ${user.name}!',
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
                                  child: ListView.builder(
                                    itemCount: research.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          if (index == 0)
                                            SizedBox(height: height * 0.03),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SurveyTile(
                                                name: research[index].name,
                                                status: research[index].status,
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.help_outline,
                                                  size: 26.sp,
                                                  color: MyColors.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'Nenhuma pesquisa disponível',
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.white),
                                  ),
                                );
                        } else if (state.status == ResearchStatus.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Center(
                            child: Text(
                              'Erro ao buscar pesquisas',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
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
