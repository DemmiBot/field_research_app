import 'package:fieldresearch/repositories/users_repository.dart';
import 'package:fieldresearch/screens/adm_page/users_adm_view/cubit/manage_users_cubit.dart';
import 'package:fieldresearch/screens/adm_page/users_adm_view/widgets/my_floatbutton.dart';
import 'package:fieldresearch/screens/adm_page/users_adm_view/widgets/table_users.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

// It's important to optimize this screen, as many users can affect performance
// Options
// - User pagination
// - Review the nested use of ScrollChildView, altering the layout

//To do
// - Get the current user and remove it from the table
// - Function to delete and change user states

class AdmUsers extends StatelessWidget {
  final IUserRepository usersRepository;
  const AdmUsers({super.key, required this.usersRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ManageUsersCubit(userRepository: usersRepository)..fetchUsers(),
      child: const AdmUsersView(),
    );
  }
}

class AdmUsersView extends StatefulWidget {
  const AdmUsersView({super.key});

  @override
  State<AdmUsersView> createState() => _AdmUsersView();
}

class _AdmUsersView extends State<AdmUsersView> {
  List<UserModel> users = [];
  int index = -1;
  @override
  Widget build(BuildContext context) {
    final UserModel currentUser =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      floatingActionButton: const MyFloatButton(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<ManageUsersCubit, ManageUsersState>(
        builder: (context, state) {
          if (state.state == UsersState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == UsersState.success) {
            users = state.users!;
            if (users.any((user) => user.name == currentUser.name)) {
              users.removeWhere((user) => user.name == currentUser.name);
            } 
            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ManageUsersCubit>().fetchUsers();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 23.h),
                      Text(
                        'Pesquisadores',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          MyButtonAdm(
                              text: 'Extrair xlsx', width: 9, onPressed: () {}),
                          SizedBox(width: 6.w),
                          MyButtonAdm(
                            text: 'Extrair CSV',
                            width: 9,
                            onPressed: () {},
                          ),
                          SizedBox(width: 7.w),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(width: 13.w),
                          MyButtonAdm(
                            text: 'Remover Pesquisador',
                            width: 9,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      TableUsers(usersData: users, index: index)
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                state.message!,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
