import 'package:fieldresearch/screens/adm_page/users_adm_view/cubit/manage_users_cubit.dart';
import 'package:fieldresearch/screens/adm_page/users_adm_view/widgets/popup_button.dart';
import 'package:fieldresearch/widgets/button_adm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';
import 'package:fieldresearch/utils/utils.dart';

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

  bool remove = false;

  Map<int, bool> selectedMap = {};

  @override
  Widget build(BuildContext context) {
    final UserModel currentUser =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      floatingActionButton: context
              .read<ManageUsersCubit>()
              .usersSelected
              .isNotEmpty
          ? FloatingActionButton(
              backgroundColor: textColorForm,
              onPressed: () => context.read<ManageUsersCubit>().deleteUsers(),
              child: const Icon(Icons.delete),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
      ),
      body: BlocListener<ManageUsersCubit, ManageUsersState>(
        listener: (context, state) {
          if (state.state == UsersState.deletionSuccess ||
              state.state == UsersState.deletionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
          if (state.state == UsersState.success) {
            users = state.users!;
            if (users.any((user) => user.name == currentUser.name)) {
              users.removeWhere((user) => user.name == currentUser.name);
            }
            selectedMap = {
              for (var index in users.asMap().keys) index: false,
            };
            context.read<ManageUsersCubit>().fetchUsers();
          }
        },
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async =>
                context.read<ManageUsersCubit>().fetchUsers(),
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
                        onPressed: () {
                          setState(() => removeUpdate());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  BlocBuilder<ManageUsersCubit, ManageUsersState>(
                      builder: (context, state) {
                    if (state.state == UsersState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.state == UsersState.failure) {
                      return Center(
                        child: Text(
                          state.message!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: const TableBorder(
                              verticalInside: BorderSide(
                                width: 0.3,
                                color: buttonColor,
                              ),
                            ),
                            decoration: const BoxDecoration(
                              color: buttonColor,
                            ),
                            columnSpacing: 10.w,
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'id',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Nome',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text('Adm',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              DataColumn(
                                label: Text('Email',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                            rows: users.asMap().entries.map(
                              (entry) {
                                final index = entry.key;
                                final user = entry.value;
                                return DataRow(
                                  color: MaterialStateProperty.all(index.isEven
                                      ? Colors.grey[300]
                                      : Colors.white),
                                  cells: [
                                    DataCell(
                                      remove
                                          ? Checkbox(
                                              value: selectedMap[index],
                                              onChanged: (value) {
                                                setState(
                                                  () => selectedMap[index] =
                                                      value!,
                                                );
                                                context
                                                    .read<ManageUsersCubit>()
                                                    .usersSelect(
                                                        value: value!,
                                                        user: user);
                                              },
                                            )
                                          : Text((index + 1).toString()),
                                    ),
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            BoxConstraints(maxWidth: 130.w),
                                        child: SingleChildScrollView(
                                          child: Text(user.name),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      PopUpButton(adm: user.adm.toString()),
                                    ),
                                    DataCell(
                                      Text(
                                        user.email,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void removeUpdate() {
    setState(() {
      remove = !remove;
      if (remove == false) {
        context.read<ManageUsersCubit>().usersSelected.clear();
        selectedMap = {
          for (var index in selectedMap.keys) index: false,
        };
      }
    });
  }
}
