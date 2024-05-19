import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:research_repository/research_repository.dart';
import 'package:user_repository/user_repository.dart';

class HomeAdmPage extends StatelessWidget {
  final String userId;
  const HomeAdmPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserModelBloc(
            repository: context.read<IUserRepository>(),
          )..add(
              GetUserData(userId: userId),
            ),
        ),
        BlocProvider(
          create: (context) =>
              ResearchModelBloc(repository: context.read<IResearchRepository>())
                ..add(GetAllResearches()),
        ),
      ],
      child: const HomeAdmView(),
    );
  }
}

class HomeAdmView extends StatefulWidget {
  const HomeAdmView({super.key});

  @override
  State<HomeAdmView> createState() => _HomeAdmViewState();
}

class _HomeAdmViewState extends State<HomeAdmView> {
  UserModel user = UserModel.empty;

  List<ResearchModel> research = [];

  bool isLoading = true;

  bool failure = false;

  bool success = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserModelBloc, UserModelState>(
      builder: (context, state) {
        if (state.status == GetStatus.success) {
          user = state.user!;
        }
        return BlocBuilder<ResearchModelBloc, ResearchModelState>(
          builder: (context, state) {
            if (state.status == ResearchStatus.success) {
              research = state.researches!;
              isLoading = false;
              success = true;
            }
            if (state.status == ResearchStatus.failure) {
              failure = true;
              isLoading = false;
            }
            return Scaffold(
              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      context.read<ResearchModelBloc>().add(GetAllResearches()),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Text(
                          'Olá, ${user.name}!',
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          'Pesquisas',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        SizedBox(height: 18.h),
                        if (isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (research.isEmpty)
                          Column(
                            children: [
                              Icon(Icons.description,
                                  color: Colors.white, size: 25.sp),
                              Center(
                                child: Text(
                                  'Nenhuma pesquisa disponível',
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        else
                          Expanded(
                            child: ListView.builder(
                              itemCount: research.length,
                              itemBuilder: (context, index) {
                                return SurveyTile(
                                  name: research[index].name,
                                  status: research[index].status,
                                );
                              },
                            ),
                          ),
                        if (failure)
                          Center(
                            child: Text(
                              'Erro ao buscar pesquisas',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                          ),
                        SizedBox(height: 24.h),
                        Center(
                          child: MyButtonAdm(
                            text: 'Novo Formulário',
                            width: 8.w,
                            onPressed: () =>
                                Navigator.pushNamed(context, '/admCreateForm'),
                          ),
                        ),
                        SizedBox(height: 24.sp),
                        Center(
                          child: MyButtonAdm(
                            text: 'Gerenciar Pesquisadores',
                            width: 10.w,
                            onPressed: () => Navigator.pushNamed(
                                context, '/admUsers',
                                arguments: user),
                          ),
                        ),
                      ],
                    ),
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
